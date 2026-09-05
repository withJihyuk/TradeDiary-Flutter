#!/usr/bin/env bash
set -euo pipefail

required=(
  DB_URL
  DB_KEY
  API_URL
  CDN_URL
  SENTRY_DSN
  GOOGLE_WEB_CLIENT_ID
  GOOGLE_IOS_CLIENT_ID
)
missing=()

for name in "${required[@]}"; do
  value="${!name:-}"
  if [[ -z "${value//[[:space:]]/}" ]]; then
    missing+=("$name")
  elif [[ "$value" == *$'\n'* || "$value" == *$'\r'* ]]; then
    echo "::error::production secret ${name} must be a single line"
    exit 1
  fi
done

if (( ${#missing[@]} )); then
  echo "::error::missing production secrets: ${missing[*]}"
  exit 1
fi

umask 077
: > .env
chmod 600 .env
for name in "${required[@]}"; do
  printf '%s=%s\n' "$name" "${!name}" >> .env
done
