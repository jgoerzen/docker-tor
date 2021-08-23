FROM jgoerzen/debian-base-security:bullseye
MAINTAINER John Goerzen <jgoerzen@complete.org>
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates && \
    apt-get update && \
    apt-get -y  install tor nyx obfs4proxy && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled

# Had issues with hidden services.
RUN sed -i -e 's/AppArmorProfile=.*//g' -e 's/ProtectSystem=.*//g' \
        -e 's/CapabilityBoundingSet=.*//g' /lib/systemd/system/tor*.service && \
    rm -v /etc/apparmor.d/system_tor
CMD ["/usr/local/bin/boot-debian-base"]

