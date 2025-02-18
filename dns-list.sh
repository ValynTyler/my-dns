#!/usr/bin/env bash

curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records \
  -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
  -H "X-Auth-Key: $CLOUDFLARE_API_KEY" | jq
