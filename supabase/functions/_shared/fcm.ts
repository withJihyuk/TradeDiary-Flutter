type FcmMessage = {
  token: string;
  title: string;
  body: string;
  data?: Record<string, string>;
};

type ServiceAccount = {
  client_email: string;
  private_key: string;
  project_id: string;
};

const encoder = new TextEncoder();

function base64Url(input: ArrayBuffer | string): string {
  const bytes = typeof input == 'string' ? encoder.encode(input) : new Uint8Array(input);
  let binary = '';
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary).replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

function serviceAccount(): ServiceAccount {
  const raw = Deno.env.get('FIREBASE_SERVICE_ACCOUNT_JSON');
  if (raw != null && raw.trim().length > 0) {
    const parsed = JSON.parse(raw) as ServiceAccount;
    return {
      client_email: parsed.client_email,
      private_key: parsed.private_key.replaceAll('\\n', '\n'),
      project_id: parsed.project_id,
    };
  }

  return {
    client_email: Deno.env.get('FIREBASE_CLIENT_EMAIL') ?? '',
    private_key: (Deno.env.get('FIREBASE_PRIVATE_KEY') ?? '').replaceAll('\\n', '\n'),
    project_id: Deno.env.get('FIREBASE_PROJECT_ID') ?? '',
  };
}

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const body = pem
    .replace('-----BEGIN PRIVATE KEY-----', '')
    .replace('-----END PRIVATE KEY-----', '')
    .replaceAll(/\s/g, '');
  const binary = atob(body);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes.buffer;
}

async function signJwt(account: ServiceAccount): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = { alg: 'RS256', typ: 'JWT' };
  const claim = {
    iss: account.client_email,
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    aud: 'https://oauth2.googleapis.com/token',
    iat: now,
    exp: now + 3600,
  };

  const signingInput = `${base64Url(JSON.stringify(header))}.${base64Url(JSON.stringify(claim))}`;
  const key = await crypto.subtle.importKey(
    'pkcs8',
    pemToArrayBuffer(account.private_key),
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign('RSASSA-PKCS1-v1_5', key, encoder.encode(signingInput));
  return `${signingInput}.${base64Url(signature)}`;
}

async function accessToken(account: ServiceAccount): Promise<string> {
  const assertion = await signJwt(account);
  const response = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion,
    }),
  });

  if (!response.ok) {
    throw new Error(`FCM OAuth failed: ${response.status} ${await response.text()}`);
  }

  const json = await response.json() as { access_token?: string };
  if (json.access_token == null) throw new Error('FCM OAuth response missing access_token');
  return json.access_token;
}

export async function sendFcmMessages(messages: FcmMessage[]): Promise<number> {
  if (messages.length == 0) return 0;

  const account = serviceAccount();
  if (account.client_email.length == 0 || account.private_key.length == 0 || account.project_id.length == 0) {
    throw new Error('Firebase service account environment is not configured');
  }

  const token = await accessToken(account);
  const endpoint = `https://fcm.googleapis.com/v1/projects/${account.project_id}/messages:send`;
  let sent = 0;

  for (const message of messages) {
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        authorization: `Bearer ${token}`,
        'content-type': 'application/json',
      },
      body: JSON.stringify({
        message: {
          token: message.token,
          notification: { title: message.title, body: message.body },
          data: message.data ?? {},
        },
      }),
    });

    if (response.ok) {
      sent++;
    } else {
      console.error('FCM send failed', response.status, await response.text());
    }
  }

  return sent;
}
