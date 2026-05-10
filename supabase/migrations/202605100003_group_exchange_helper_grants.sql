-- migration: group_exchange_helper_grants
-- purpose: allow authenticated RLS policies to call helper functions while keeping anon blocked

revoke execute on function public.can_manage_comment(uuid) from public, anon;
revoke execute on function public.is_active_group_member(uuid) from public, anon;
revoke execute on function public.is_group_owner(uuid) from public, anon;
revoke execute on function public.publish_round_if_ready(uuid) from public, anon, authenticated;
revoke execute on function public.publish_due_rounds() from public, anon, authenticated;

grant execute on function public.can_manage_comment(uuid) to authenticated;
grant execute on function public.is_active_group_member(uuid) to authenticated;
grant execute on function public.is_group_owner(uuid) to authenticated;
