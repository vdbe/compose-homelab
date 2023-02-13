# Compose homlab
A simple modular homelab constructed of multiple docker-compose.yaml files.

## Modules

## Cloudflare tunnel
[Cloudflared](https://hub.docker.com/r/cloudflare/cloudflared)

1. Create an Tunnel \
    https://one.dash.cloudflare.com/ -> Acces -> Tunnels -> Create tunnel
2. Add public hostname \
    1. tunnel -> Public Hostname -> Add public Hostname
    2. Service -> Type: `HTTPS`, URL: `ingress-cloudflare` \
        (You can also directly go to your service without `traefik``)
    3. Addition applictation settings \
        TLS -> Origin Server Name: `<Subdoain>.<Domain>` -> `whoami.example.com`

### Searx
[Searx](https://github.com/searxng/searxng)

### Traefik
[Traefik](https://github.com/traefik/traefik)

**REQUIRED MODULE**

### Vaultwarden
[Vaultwarden](https://github.com/dani-garcia/vaultwarden)

### Watchtower
[Watchtower](https://github.com/containrrr/watchtower)

## Whoami
[Whoami](https://github.com/traefik/whoami)

## Xen-Orchstra
[Xen-Orchstra](https://github.com/ronivay/xen-orchestra-docker)

## Setup
1. Clones this repo
3. `cp example.env .env`
4. Fill in the secrets under ./secret/
5. Enable the modules you want (traefik is required) \
    You can do this by editing `COMPOSE_MODULES` in `.env`
6. `./docker-compose.sh up -d`

## Structure
- `./docker-compose/`: The docker-compose files
- `./docker/`: Custom docker files
- `./secret/`: The secrets
- `./config/`: Additional config for services suchs as env_files
- `./volume/`: Data that cannot be regenerated with a simple `docker compose up`
