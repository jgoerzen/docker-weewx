FROM jgoerzen/debian-base-security:bullseye
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
# UPDATE CI ALSO
ENV WEEWX_VERSION 4.6.0
# The font file is used for the generated images
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx

VOLUME ["/var/lib/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
