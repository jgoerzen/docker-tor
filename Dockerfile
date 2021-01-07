FROM jgoerzen/debian-base-security:buster
MAINTAINER John Goerzen <jgoerzen@complete.org>
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates && \
    echo 'deb https://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y -t buster-backports install tor nyx obfs4proxy && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled

VOLUME ["/var/spool/uucp"]
CMD ["/usr/local/bin/boot-debian-base"]

