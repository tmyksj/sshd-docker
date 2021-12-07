#!/bin/bash
set -eo pipefail
shopt -s nullglob

if [ ! -f /etc/ssh/ssh_host_ecdsa_key ]; then
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N "" -t ecdsa
fi

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N "" -t ed25519
fi

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N "" -t rsa
fi

for f in /docker-entrypoint-init.d/*; do
    case "$f" in
        *.sh)
            if [ -x "$f" ]; then
                "$f"
            else
                . "$f"
            fi
            ;;
    esac
done

exec "$@"
