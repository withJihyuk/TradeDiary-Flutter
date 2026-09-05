import { createClient } from 'npm:@supabase/supabase-js@2.115.0';

const headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Content-Type': 'application/json',
};

Deno.serve(async (request) => {
  const reply = (status: number, body: object) =>
    new Response(JSON.stringify(body), { status, headers });
  if (request.method === 'OPTIONS') return new Response('ok', { headers });
  if (!['GET', 'POST'].includes(request.method)) return reply(405, { error: 'Method not allowed' });
  const token = request.headers.get('Authorization')?.replace(/^Bearer /, '');
  if (!token) return reply(401, { error: 'Login required' });
  const client = createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!);
  const { data: { user }, error } = await client.auth.getUser(token);
  if (error || !user) return reply(401, { error: 'Login required' });
  const { error: deletionError } = await client.auth.admin.deleteUser(user.id);
  if (deletionError) return reply(500, { error: '계정을 삭제하지 못했어요. 다시 시도해 주세요.' });
  return reply(200, { deleted: true });
});
