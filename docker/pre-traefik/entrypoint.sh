#!/usr/bin/env sh
# Usage:
# ./entrypoint.sh /etc/traefik/traefik.yml

# TODO: Rewrite this to use arguments, so it can be modified in a compose file
# using:
#   command:
#       - ...
#       - ...
#

# This script is being ran before traefik starts
# This way we can edit `/etc/traefik/traefik.yaml` to fit the docker env

TRAEFIK_FILE="$1"
shift 1

yq_blank() {
    cp "$2" "$2.old" 
    yq eval "$1" "$2.old" > "$2.new"
    diff -B "$2.old" "$2.new" > "$2.patch"
    patch "$2.old" "$2.patch"

    cat "$2.old" > "$2"
}

set_trusted_ips() {
    # 10_cloudflare is always eth1
    # this is ethn seems to be ordered alphabetical (ASCII table)
    # eth0: 00_net_traefik
    # eth1: 10_cloudflare_tunnel
    subnet_10_cloudflare="$(ip -o -f inet addr show eth1 | awk '/scope global/ {print $4}')"
    subnet_10_cloudflare="\"$subnet_10_cloudflare\""
    export subnet_10_cloudflare

    query='.entryPoints.cloudflare.forwardedHeaders.trustedIPs = [ env(subnet_10_cloudflare) ]'

    #yq_blank "$query"  \
    #    "$TRAEFIK_FILE"
    yq eval --inplace "$query"  \
        "$TRAEFIK_FILE"
}

set_acme_provider() {
    query=".certificatesResolvers.$1.acme.dnsChallenge.provider = env(ACME_PROVIDER)"

    #yq_blank "$query"  \
    #    "$TRAEFIK_FILE"
    yq eval --inplace "$query"  \
        "$TRAEFIK_FILE"
}

set_trusted_ips
set_acme_provider staging
set_acme_provider production
