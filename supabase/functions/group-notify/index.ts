import { createClient } from 'npm:@supabase/supabase-js@2';
import { sendFcmMessages } from '../_shared/fcm.ts';

type NotifyPayload = {
  type: 'round_published' | 'comment_created' | 'reaction_created' | 'member_joined';
  groupId: string;
  actorId?: string;
  title: string;
  body: string;
  deepLink: string;
};

Deno.serve(async (req) => {
  if (req.method != 'POST') {
    return new Response('Method not allowed', { status: 405 });
  }

  const payload = await req.json() as NotifyPayload;
  if (payload.groupId == null || payload.title == null || payload.body == null) {
    return new Response('Invalid payload', { status: 400 });
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
  );

  const { data: members, error: membersError } = await supabase
    .from('group_members')
    .select('user_id')
    .eq('group_id', payload.groupId)
    .eq('status', 'active');

  if (membersError != null) {
    console.error(membersError);
    return new Response('Failed to load group members', { status: 500 });
  }

  const recipientIds = (members ?? [])
    .map((member) => member.user_id as string)
    .filter((userId) => userId != payload.actorId);

  if (recipientIds.length == 0) {
    return Response.json({ sent: 0 });
  }

  const { data: tokens, error: tokensError } = await supabase
    .from('user_push_tokens')
    .select('token')
    .in('user_id', recipientIds)
    .eq('enabled', true);

  if (tokensError != null) {
    console.error(tokensError);
    return new Response('Failed to load push tokens', { status: 500 });
  }

  const sent = await sendFcmMessages(
    (tokens ?? []).map((row) => ({
      token: row.token as string,
      title: payload.title,
      body: payload.body,
      data: {
        type: payload.type,
        groupId: payload.groupId,
        deepLink: payload.deepLink,
      },
    })),
  );

  return Response.json({ sent });
});
