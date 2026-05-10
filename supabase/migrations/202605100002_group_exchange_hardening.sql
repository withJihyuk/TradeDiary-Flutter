-- migration: group_exchange_hardening
-- purpose: restrict group diary RPC execution and add FK covering indexes flagged by advisors

revoke execute on function public.can_manage_comment(uuid) from public, anon, authenticated;
revoke execute on function public.is_active_group_member(uuid) from public, anon, authenticated;
revoke execute on function public.is_group_owner(uuid) from public, anon, authenticated;
revoke execute on function public.publish_round_if_ready(uuid) from public, anon, authenticated;
revoke execute on function public.publish_due_rounds() from public, anon, authenticated;

revoke execute on function public.create_group(text, time without time zone) from public, anon;
revoke execute on function public.join_group_by_invite(text) from public, anon;
revoke execute on function public.get_or_create_today_round(uuid) from public, anon;
revoke execute on function public.share_entry_to_group(uuid, uuid, date) from public, anon;
revoke execute on function public.cancel_group_share(uuid) from public, anon;

grant execute on function public.create_group(text, time without time zone) to authenticated;
grant execute on function public.join_group_by_invite(text) to authenticated;
grant execute on function public.get_or_create_today_round(uuid) to authenticated;
grant execute on function public.share_entry_to_group(uuid, uuid, date) to authenticated;
grant execute on function public.cancel_group_share(uuid) to authenticated;

create index if not exists group_invites_group_id_idx on public.group_invites(group_id);
create index if not exists group_invites_created_by_idx on public.group_invites(created_by);
create index if not exists group_entry_shares_round_id_idx on public.group_entry_shares(round_id);
create index if not exists group_entry_shares_user_id_idx on public.group_entry_shares(user_id);
create index if not exists entry_comments_user_id_idx on public.entry_comments(user_id);
create index if not exists entry_comments_hidden_by_idx on public.entry_comments(hidden_by);
create index if not exists entry_reactions_user_id_idx on public.entry_reactions(user_id);
create index if not exists user_push_tokens_user_id_idx on public.user_push_tokens(user_id);

drop policy if exists "entry_comments_insert_published_round_members" on public.entry_comments;
create policy "entry_comments_insert_published_round_members" on public.entry_comments
  for insert to authenticated
  with check (
    user_id = (select auth.uid())
    and exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

drop policy if exists "entry_reactions_insert_self_published_round_members" on public.entry_reactions;
create policy "entry_reactions_insert_self_published_round_members" on public.entry_reactions
  for insert to authenticated
  with check (
    user_id = (select auth.uid())
    and exists (
      select 1
      from public.group_entry_shares s
      join public.group_rounds r on r.id = s.round_id
      where s.id = share_id
        and r.status = 'published'
        and public.is_active_group_member(s.group_id)
    )
  );

drop policy if exists "entry_reactions_delete_self" on public.entry_reactions;
create policy "entry_reactions_delete_self" on public.entry_reactions
  for delete to authenticated
  using (user_id = (select auth.uid()));

drop policy if exists "user_push_tokens_select_self" on public.user_push_tokens;
create policy "user_push_tokens_select_self" on public.user_push_tokens
  for select to authenticated
  using (user_id = (select auth.uid()));

drop policy if exists "user_push_tokens_insert_self" on public.user_push_tokens;
create policy "user_push_tokens_insert_self" on public.user_push_tokens
  for insert to authenticated
  with check (user_id = (select auth.uid()));

drop policy if exists "user_push_tokens_update_self" on public.user_push_tokens;
create policy "user_push_tokens_update_self" on public.user_push_tokens
  for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

drop policy if exists "user_push_tokens_delete_self" on public.user_push_tokens;
create policy "user_push_tokens_delete_self" on public.user_push_tokens
  for delete to authenticated
  using (user_id = (select auth.uid()));

drop policy if exists "diary_update_own_unlocked" on public.diary;
create policy "diary_update_own_unlocked" on public.diary
  for update to authenticated
  using ("userId" = (select auth.uid()) and "lockedAt" is null and "deletedAt" is null)
  with check ("userId" = (select auth.uid()));

drop policy if exists "group_members_update_owner_or_self_leave" on public.group_members;
create policy "group_members_update_owner_or_self_leave" on public.group_members
  for update to authenticated
  using (public.is_group_owner(group_id) or user_id = (select auth.uid()))
  with check (public.is_group_owner(group_id) or user_id = (select auth.uid()));
