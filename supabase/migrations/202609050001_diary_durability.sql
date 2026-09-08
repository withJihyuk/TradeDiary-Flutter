begin;

alter table public.diary
  add column "diaryDate" date,
  add column "completedAt" timestamptz,
  add column "contentText" text not null default '',
  add column revision bigint not null default 1,
  add column "lastMutationId" uuid;

create function public.diary_plain_text(value text) returns text
language plpgsql immutable set search_path = '' as $$
declare parsed jsonb;
begin
  begin parsed := value::jsonb; exception when others then return coalesce(value, ''); end;
  if jsonb_typeof(parsed) <> 'array' then return coalesce(value, ''); end if;
  return coalesce((select string_agg(op->>'insert', '' order by n)
    from jsonb_array_elements(parsed) with ordinality as t(op, n)
    where jsonb_typeof(op->'insert') = 'string'), '');
end $$;

update public.diary set
  "diaryDate" = case when "isDraft" is not true then ("createdAt" at time zone 'Asia/Seoul')::date end,
  "contentText" = public.diary_plain_text(content);

-- Historical duplicate dates remain intact; all future completions are unique.
create unique index diary_new_completion_day on public.diary ("userId", "diaryDate")
  where "completedAt" is not null and "isDraft" is false;
create index diary_owner_date on public.diary ("userId", "diaryDate" desc, id desc);
create index diary_owner_drafts on public.diary ("userId", "updatedAt" desc) where "isDraft" is true;

alter table public.diary add constraint diary_auth_owner foreign key ("userId")
  references auth.users(id) on delete cascade not valid;
alter table public.profile add constraint profile_auth_owner foreign key (id)
  references auth.users(id) on delete cascade not valid;

create function public.enforce_diary_write() returns trigger
language plpgsql security definer set search_path = '' as $$
declare completing boolean; plain text; units integer;
begin
  if auth.uid() is not null and new."userId" <> auth.uid() then
    raise exception 'Forbidden' using errcode = '42501';
  end if;
  if tg_op = 'UPDATE' and new."userId" <> old."userId" then
    raise exception 'Owner cannot change' using errcode = '42501';
  end if;
  completing := new."isDraft" is not true and (tg_op = 'INSERT' or old."isDraft" is true);
  new."isDraft" := coalesce(new."isDraft", false);
  new."updatedAt" := clock_timestamp();
  new.revision := case when tg_op = 'INSERT' then 1 else old.revision + 1 end;
  new."contentText" := public.diary_plain_text(new.content);
  -- A legacy write must not retain a newer client's retry token.
  if tg_op = 'UPDATE' and new."lastMutationId" is not distinct from old."lastMutationId" then
    new."lastMutationId" := null;
  end if;
  if tg_op = 'UPDATE' then
    new."createdAt" := old."createdAt";
    new."diaryDate" := old."diaryDate";
    new."completedAt" := old."completedAt";
  else
    new."createdAt" := clock_timestamp();
    new."diaryDate" := null;
    new."completedAt" := null;
  end if;
  if completing then
    -- Same lock is used by RPCs and legacy direct writes.
    perform pg_advisory_xact_lock(hashtextextended(new."userId"::text, 0));
    new."completedAt" := clock_timestamp();
    new."diaryDate" := (new."completedAt" at time zone 'Asia/Seoul')::date;
    if exists (select 1 from public.diary where "userId" = new."userId"
      and "diaryDate" = new."diaryDate" and "isDraft" is not true and id <> new.id) then
      raise exception '오늘은 이미 일기를 작성했어요' using errcode = '23505';
    end if;
    plain := btrim(new."contentText", E' \n\r\t');
    -- Dart String.length counts UTF-16 code units, including emoji surrogate pairs.
    select coalesce(sum(case when ascii(c) > 65535 then 2 else 1 end), 0)
      into units from regexp_split_to_table(plain, '') c;
    if units = 0 or units > 500 then
      raise exception '내용은 1자 이상 500자 이내로 입력해 주세요' using errcode = '22023';
    end if;
    update public.profile set exp = coalesce(exp, 0) + 1 where id = new."userId";
    if not found then raise exception 'Profile missing'; end if;
  end if;
  return new;
end $$;

-- Legacy clients may write content, but retry tokens belong to authenticated RPCs.
revoke insert, update on public.diary from authenticated;
grant insert (id, "userId", subject, content, emotion, "isDraft", "createdAt", "updatedAt") on public.diary to authenticated;
grant update ("userId", subject, content, emotion, "isDraft", "updatedAt") on public.diary to authenticated;

create trigger enforce_diary_write before insert or update on public.diary
for each row execute function public.enforce_diary_write();

-- The RPC implementation stays private; named entry points form the API.
create function public.mutate_diary(p_id uuid, p_revision bigint, p_mutation_id uuid,
  p_subject text, p_content text, p_emotion text, p_action text) returns jsonb
language plpgsql security definer set search_path = '' as $$
declare owner uuid := auth.uid(); row public.diary; parsed jsonb;
begin
  if owner is null then raise exception 'Login required' using errcode = '42501'; end if;
  if p_id is null or p_mutation_id is null or p_revision is null or p_revision < 0 then
    raise exception 'Invalid request' using errcode = '22023';
  end if;
  perform pg_advisory_xact_lock(hashtextextended(owner::text, 0));
  select * into row from public.diary where id = p_id for update;
  if found then
    if row."userId" <> owner then raise exception 'Forbidden' using errcode = '42501'; end if;
    if row."isDraft" is not true then return jsonb_build_object('status', 'completed', 'diary', to_jsonb(row)); end if;
    if row."lastMutationId" = p_mutation_id and p_action = 'save' then
      return jsonb_build_object('status', 'saved', 'diary', to_jsonb(row));
    end if;
    if row.revision <> p_revision then return jsonb_build_object('status', 'conflict', 'diary', to_jsonb(row)); end if;
  elsif p_revision <> 0 or p_action = 'delete' then
    return jsonb_build_object('status', 'deleted');
  end if;
  if p_action = 'delete' then
    delete from public.diary where id = p_id and "userId" = owner;
    return jsonb_build_object('status', 'deleted');
  end if;
  if p_action not in ('save', 'complete') or p_subject is null or p_content is null or p_emotion is null then
    raise exception 'Invalid request' using errcode = '22023';
  end if;
  -- A device file path cannot be restored on another device.
  begin parsed := p_content::jsonb; exception when others then parsed := null; end;
  if jsonb_typeof(parsed) = 'array' and exists (
    select 1 from jsonb_array_elements(parsed) op where op->'insert' ? 'image'
    and coalesce(op->'insert'->>'image', '') !~ '^https://') then
    raise exception '이미지 업로드를 먼저 완료해 주세요' using errcode = '22023';
  end if;
  if jsonb_typeof(parsed) = 'array' and (select count(*) from jsonb_array_elements(parsed) op where op->'insert' ? 'image') > 10 then
    raise exception '사진은 최대 10장까지 추가할 수 있어요' using errcode = '22023';
  end if;
  if p_action = 'complete' and exists (select 1 from public.diary
    where "userId" = owner and "isDraft" is not true
    and "diaryDate" = (clock_timestamp() at time zone 'Asia/Seoul')::date) then
    return jsonb_build_object('status', 'duplicate_day');
  end if;
  if row.id is null then
    insert into public.diary (id, "userId", subject, content, emotion, "isDraft", "lastMutationId")
      values (p_id, owner, p_subject, p_content, p_emotion, p_action <> 'complete', p_mutation_id)
      returning * into row;
  else
    update public.diary set subject = p_subject, content = p_content, emotion = p_emotion,
      "isDraft" = p_action <> 'complete', "lastMutationId" = p_mutation_id
      where id = p_id and "userId" = owner returning * into row;
  end if;
  return jsonb_build_object('status', case when p_action = 'complete' then 'completed' else 'saved' end,
    'diary', to_jsonb(row));
end $$;
revoke all on function public.mutate_diary(uuid, bigint, uuid, text, text, text, text) from public, anon, authenticated;

create function public.save_draft(p_id uuid, p_revision bigint, p_mutation_id uuid,
  p_subject text, p_content text, p_emotion text) returns jsonb
language sql security definer set search_path = '' as $$
  select public.mutate_diary(p_id, p_revision, p_mutation_id, p_subject, p_content, p_emotion, 'save');
$$;
create function public.finalize_diary(p_id uuid, p_revision bigint, p_mutation_id uuid,
  p_subject text, p_content text, p_emotion text) returns jsonb
language sql security definer set search_path = '' as $$
  select public.mutate_diary(p_id, p_revision, p_mutation_id, p_subject, p_content, p_emotion, 'complete');
$$;
create function public.delete_draft(p_id uuid, p_revision bigint, p_mutation_id uuid) returns jsonb
language sql security definer set search_path = '' as $$
  select public.mutate_diary(p_id, p_revision, p_mutation_id, null, null, null, 'delete');
$$;

create function public.search_diaries(p_query text default '', p_offset integer default 0, p_limit integer default 20)
returns setof public.diary language sql stable security invoker set search_path = '' as $$
  select * from public.diary where "userId" = auth.uid() and "isDraft" is not true
    and (strpos(lower(coalesce(subject, '')), lower(p_query)) > 0
      or strpos(lower("contentText"), lower(p_query)) > 0)
    order by "diaryDate" desc, id desc limit least(greatest(p_limit, 1), 100) offset greatest(p_offset, 0);
$$;
revoke all on function public.save_draft(uuid,bigint,uuid,text,text,text),
  public.finalize_diary(uuid,bigint,uuid,text,text,text), public.delete_draft(uuid,bigint,uuid),
  public.search_diaries(text,integer,integer) from public, anon;
grant execute on function public.save_draft(uuid,bigint,uuid,text,text,text),
  public.finalize_diary(uuid,bigint,uuid,text,text,text), public.delete_draft(uuid,bigint,uuid),
  public.search_diaries(text,integer,integer) to authenticated;

commit;
