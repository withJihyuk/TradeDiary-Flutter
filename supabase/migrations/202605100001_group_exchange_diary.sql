-- migration: group_exchange_diary
-- purpose: add group-based exchange diary rounds while preserving existing personal diary rows
-- affected tables: diary, profile, groups, group_members, group_invites, group_rounds,
--                  group_entry_shares, entry_comments, entry_reactions, user_push_tokens
-- special considerations:
--   - Existing public.diary rows remain personal archive entries.
--   - Group visibility is granted through published group_entry_shares.
--   - Users may write many personal diary rows per day, but can share only one active entry
--     per group round.

alter table public.diary
  add column if not exists "lockedAt" timestamp with time zone,
  add column if not exists "deletedAt" timestamp with time zone;

create table if not exists public.groups (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(trim(name)) between 1 and 40),
  owner_id uuid not null references auth.users(id) on delete cascade,
  deadline_time time without time zone not null default time '23:59',
  timezone text not null default 'Asia/Seoul',
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  archived_at timestamp with time zone
);

create table if not exists public.group_members (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null default 'member' check (role in ('owner', 'member')),
  status text not null default 'active' check (status in ('active', 'left', 'removed')),
  joined_at timestamp with time zone not null default now(),
  left_at timestamp with time zone,
  unique (group_id, user_id)
);

create table if not exists public.group_invites (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  code text not null unique,
  created_by uuid not null references auth.users(id) on delete cascade,
  expires_at timestamp with time zone,
  revoked_at timestamp with time zone,
  created_at timestamp with time zone not null default now()
);

create table if not exists public.group_rounds (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  round_date date not null,
  deadline_at timestamp with time zone not null,
  status text not null default 'open' check (status in ('open', 'published')),
  published_at timestamp with time zone,
  created_at timestamp with time zone not null default now(),
  unique (group_id, round_date)
);

create table if not exists public.group_entry_shares (
  id uuid primary key default gen_random_uuid(),
  group_id uuid not null references public.groups(id) on delete cascade,
  round_id uuid not null references public.group_rounds(id) on delete cascade,
  entry_id uuid not null references public.diary(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  shared_at timestamp with time zone not null default now(),
  canceled_at timestamp with time zone,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

create unique index if not exists group_entry_shares_one_active_per_round
  on public.group_entry_shares(group_id, round_id, user_id)
  where canceled_at is null;

create table if not exists public.entry_comments (
  id uuid primary key default gen_random_uuid(),
  share_id uuid not null references public.group_entry_shares(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  body text not null check (char_length(trim(body)) between 1 and 500),
  hidden_at timestamp with time zone,
  hidden_by uuid references auth.users(id) on delete set null,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

create table if not exists public.entry_reactions (
  id uuid primary key default gen_random_uuid(),
  share_id uuid not null references public.group_entry_shares(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  reaction text not null default 'heart' check (reaction in ('heart')),
  created_at timestamp with time zone not null default now(),
  unique (share_id, user_id, reaction)
);

create table if not exists public.user_push_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  token text not null unique,
  platform text not null check (platform in ('android', 'ios')),
  enabled boolean not null default true,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

create index if not exists groups_owner_id_idx on public.groups(owner_id);
create index if not exists group_members_user_id_idx on public.group_members(user_id);
create index if not exists group_rounds_group_date_idx on public.group_rounds(group_id, round_date desc);
create index if not exists group_entry_shares_entry_id_idx on public.group_entry_shares(entry_id);
create index if not exists entry_comments_share_id_idx on public.entry_comments(share_id, created_at);
create index if not exists entry_reactions_share_id_idx on public.entry_reactions(share_id);

create or replace function public.is_active_group_member(target_group_id uuid)
returns boolean
language sql
security definer
set search_path = ''
stable
as $$
  select exists (
    select 1
    from public.group_members gm
    where gm.group_id = target_group_id
      and gm.user_id = auth.uid()
      and gm.status = 'active'
  );
$$;

create or replace function public.is_group_owner(target_group_id uuid)
returns boolean
language sql
security definer
set search_path = ''
stable
as $$
  select exists (
    select 1
    from public.group_members gm
    where gm.group_id = target_group_id
      and gm.user_id = auth.uid()
      and gm.role = 'owner'
      and gm.status = 'active'
  );
$$;

create or replace function public.can_manage_comment(target_comment_id uuid)
returns boolean
language sql
security definer
set search_path = ''
stable
as $$
  select exists (
    select 1
    from public.entry_comments c
    join public.group_entry_shares s on s.id = c.share_id
    where c.id = target_comment_id
      and (
        c.user_id = auth.uid()
        or s.user_id = auth.uid()
        or public.is_group_owner(s.group_id)
      )
  );
$$;

create or replace function public.create_group(group_name text, group_deadline time without time zone default time '23:59')
returns public.groups
language plpgsql
security definer
set search_path = ''
as $$
declare
  created_group public.groups;
  invite_code text;
begin
  if auth.uid() is null then
    raise exception 'authentication required';
  end if;

  insert into public.groups(name, owner_id, deadline_time)
  values (trim(group_name), auth.uid(), coalesce(group_deadline, time '23:59'))
  returning * into created_group;

  insert into public.group_members(group_id, user_id, role, status)
  values (created_group.id, auth.uid(), 'owner', 'active');

  invite_code := upper(substr(replace(created_group.id::text, '-', ''), 1, 8));

  insert into public.group_invites(group_id, code, created_by)
  values (created_group.id, invite_code, auth.uid());

  return created_group;
end;
$$;

create or replace function public.join_group_by_invite(invite_code text)
returns public.group_members
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_invite public.group_invites;
  membership public.group_members;
begin
  if auth.uid() is null then
    raise exception 'authentication required';
  end if;

  select *
  into target_invite
  from public.group_invites gi
  where gi.code = upper(trim(invite_code))
    and gi.revoked_at is null
    and (gi.expires_at is null or gi.expires_at > now())
  limit 1;

  if target_invite.id is null then
    raise exception 'invalid invite code';
  end if;

  insert into public.group_members(group_id, user_id, role, status, joined_at, left_at)
  values (target_invite.group_id, auth.uid(), 'member', 'active', now(), null)
  on conflict (group_id, user_id)
  do update set status = 'active', role = public.group_members.role, joined_at = now(), left_at = null
  returning * into membership;

  return membership;
end;
$$;

create or replace function public.get_or_create_today_round(target_group_id uuid)
returns public.group_rounds
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_group public.groups;
  today date;
  deadline timestamp with time zone;
  round public.group_rounds;
begin
  if not public.is_active_group_member(target_group_id) then
    raise exception 'group membership required';
  end if;

  select * into target_group
  from public.groups g
  where g.id = target_group_id
    and g.archived_at is null;

  if target_group.id is null then
    raise exception 'group not found';
  end if;

  today := (now() at time zone target_group.timezone)::date;
  deadline := ((today::timestamp + target_group.deadline_time) at time zone target_group.timezone);

  insert into public.group_rounds(group_id, round_date, deadline_at)
  values (target_group_id, today, deadline)
  on conflict (group_id, round_date) do update
    set deadline_at = excluded.deadline_at
  returning * into round;

  return round;
end;
$$;

create or replace function public.share_entry_to_group(
  target_entry_id uuid,
  target_group_id uuid,
  target_round_date date default null
)
returns public.group_entry_shares
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_group public.groups;
  target_round public.group_rounds;
  active_share public.group_entry_shares;
begin
  if auth.uid() is null then
    raise exception 'authentication required';
  end if;

  if not public.is_active_group_member(target_group_id) then
    raise exception 'group membership required';
  end if;

  if not exists (
    select 1 from public.diary d
    where d.id = target_entry_id
      and d."userId" = auth.uid()
      and coalesce(d."isDraft", false) is false
      and d."deletedAt" is null
  ) then
    raise exception 'shareable diary entry not found';
  end if;

  select * into target_group from public.groups g where g.id = target_group_id;

  insert into public.group_rounds(group_id, round_date, deadline_at)
  values (
    target_group_id,
    coalesce(target_round_date, (now() at time zone target_group.timezone)::date),
    ((coalesce(target_round_date, (now() at time zone target_group.timezone)::date)::timestamp + target_group.deadline_time) at time zone target_group.timezone)
  )
  on conflict (group_id, round_date) do update
    set deadline_at = excluded.deadline_at
  returning * into target_round;

  if target_round.status = 'published' then
    raise exception 'published rounds cannot be changed';
  end if;

  update public.group_entry_shares
  set entry_id = target_entry_id,
      canceled_at = null,
      updated_at = now()
  where group_id = target_group_id
    and round_id = target_round.id
    and user_id = auth.uid()
    and canceled_at is null
  returning * into active_share;

  if active_share.id is null then
    insert into public.group_entry_shares(group_id, round_id, entry_id, user_id)
    values (target_group_id, target_round.id, target_entry_id, auth.uid())
    returning * into active_share;
  end if;

  perform public.publish_round_if_ready(target_round.id);

  return active_share;
end;
$$;

create or replace function public.cancel_group_share(target_share_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.group_entry_shares s
  set canceled_at = now(), updated_at = now()
  from public.group_rounds r
  where s.id = target_share_id
    and s.round_id = r.id
    and s.user_id = auth.uid()
    and s.canceled_at is null
    and r.status = 'open';

  if not found then
    raise exception 'share cannot be canceled';
  end if;
end;
$$;

create or replace function public.publish_round_if_ready(target_round_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_round public.group_rounds;
  active_member_count integer;
  active_share_count integer;
begin
  select * into target_round
  from public.group_rounds r
  where r.id = target_round_id;

  if target_round.id is null or target_round.status = 'published' then
    return;
  end if;

  select count(*) into active_member_count
  from public.group_members gm
  where gm.group_id = target_round.group_id
    and gm.status = 'active';

  select count(*) into active_share_count
  from public.group_entry_shares s
  where s.round_id = target_round.id
    and s.canceled_at is null;

  if active_member_count > 0 and active_share_count >= active_member_count then
    update public.group_rounds
    set status = 'published', published_at = now()
    where id = target_round.id;

    update public.diary d
    set "lockedAt" = coalesce(d."lockedAt", now())
    where exists (
      select 1 from public.group_entry_shares s
      where s.round_id = target_round.id
        and s.entry_id = d.id
        and s.canceled_at is null
    );
  end if;
end;
$$;

create or replace function public.publish_due_rounds()
returns integer
language plpgsql
security definer
set search_path = ''
as $$
declare
  published_count integer;
begin
  update public.group_rounds r
  set status = 'published', published_at = now()
  where r.status = 'open'
    and r.deadline_at <= now()
    and exists (
      select 1 from public.group_entry_shares s
      where s.round_id = r.id
        and s.canceled_at is null
    );

  get diagnostics published_count = row_count;

  update public.diary d
  set "lockedAt" = coalesce(d."lockedAt", now())
  where exists (
    select 1
    from public.group_entry_shares s
    join public.group_rounds r on r.id = s.round_id
    where s.entry_id = d.id
      and s.canceled_at is null
      and r.status = 'published'
  );

  return published_count;
end;
$$;

alter table public.groups enable row level security;
alter table public.group_members enable row level security;
alter table public.group_invites enable row level security;
alter table public.group_rounds enable row level security;
alter table public.group_entry_shares enable row level security;
alter table public.entry_comments enable row level security;
alter table public.entry_reactions enable row level security;
alter table public.user_push_tokens enable row level security;

create policy "groups_select_active_members" on public.groups
  for select to authenticated
  using (public.is_active_group_member(id));

create policy "groups_update_owner" on public.groups
  for update to authenticated
  using (public.is_group_owner(id))
  with check (public.is_group_owner(id));

create policy "group_members_select_active_group" on public.group_members
  for select to authenticated
  using (public.is_active_group_member(group_id));

create policy "group_members_update_owner_or_self_leave" on public.group_members
  for update to authenticated
  using (public.is_group_owner(group_id) or user_id = auth.uid())
  with check (public.is_group_owner(group_id) or user_id = auth.uid());

create policy "group_invites_select_owner" on public.group_invites
  for select to authenticated
  using (public.is_group_owner(group_id));

create policy "group_rounds_select_members" on public.group_rounds
  for select to authenticated
  using (public.is_active_group_member(group_id));

create policy "group_entry_shares_select_members" on public.group_entry_shares
  for select to authenticated
  using (public.is_active_group_member(group_id));

create policy "entry_comments_select_published_round_members" on public.entry_comments
  for select to authenticated
  using (
    exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

create policy "entry_comments_insert_published_round_members" on public.entry_comments
  for insert to authenticated
  with check (
    user_id = auth.uid()
    and exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

create policy "entry_comments_update_managers" on public.entry_comments
  for update to authenticated
  using (public.can_manage_comment(id))
  with check (public.can_manage_comment(id));

create policy "entry_reactions_select_published_round_members" on public.entry_reactions
  for select to authenticated
  using (
    exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

create policy "entry_reactions_insert_self_published_round_members" on public.entry_reactions
  for insert to authenticated
  with check (
    user_id = auth.uid()
    and exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

create policy "entry_reactions_delete_self" on public.entry_reactions
  for delete to authenticated
  using (user_id = auth.uid());

create policy "user_push_tokens_select_self" on public.user_push_tokens
  for select to authenticated
  using (user_id = auth.uid());

create policy "user_push_tokens_insert_self" on public.user_push_tokens
  for insert to authenticated
  with check (user_id = auth.uid());

create policy "user_push_tokens_update_self" on public.user_push_tokens
  for update to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "user_push_tokens_delete_self" on public.user_push_tokens
  for delete to authenticated
  using (user_id = auth.uid());

create policy "diary_select_published_group_members" on public.diary
  for select to authenticated
  using (
    "deletedAt" is null
    and exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.entry_id = public.diary.id
        and s.canceled_at is null
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

create policy "diary_update_own_unlocked" on public.diary
  for update to authenticated
  using ("userId" = auth.uid() and "lockedAt" is null and "deletedAt" is null)
  with check ("userId" = auth.uid());
