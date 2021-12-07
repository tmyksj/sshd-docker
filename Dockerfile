FROM buildpack-deps:bullseye

RUN set -ex; \
    apt-get update; \
    apt-get install -y openssh-server; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /etc/ssh/ssh_host_*; \
    mkdir -p /var/run/sshd

RUN set -ex; \
    mkdir /docker-entrypoint-init.d

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
