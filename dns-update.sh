#!/usr/bin/env bash

export DNS_RECORD_CONTENT="$(curl ifconfig.me)"
export DNS_RECORD_NAME="valyntyler.com"

curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
  -X PATCH \
  -H 'Content-Type: application/json' \
  -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
  -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
  -d '{
  "content": "'"$DNS_RECORD_CONTENT"'",
  "name": "'"$DNS_RECORD_NAME"'",
  "proxied": true,
  "ttl": 3600,
  "type": "A"
}' | jq
