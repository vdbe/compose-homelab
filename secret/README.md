# Secret

## cf_api_email
email used for cloudflare logins

## cf_dns_api_token
- Zone -> Dns -> Edit
- Include -> Specific Zone -> `SECRET_DOMAIN`

## cf_zone_api_token
- Zone -> Zone -> Read
- Include -> Specific Zone -> `SECRET_DOMAIN`

## cf_tunnel_cred_file
Create the tunnel first \
`cloudflared tunnel token --cred-file cf_tunnel_cred_file.secret "$TUNNEL_NAME"`

## cf_tunnel_cred_file
Create the tunnel first \
`cloudflared tunnel token --cred-file cf_tunnel_cred_file.secret "$TUNNEL_NAME"`

## searx_secret_key
`openssl rand -hex 32 > searx_secret_key.secret`
