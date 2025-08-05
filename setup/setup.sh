#!/bin/bash

set -e
set -x

cd /tmp/setup

# There is a bug in how usermod is called in the weewx postinst to add the weewx
# user to the weewx group.  Also we need constant UIDs for Docker, so set it up here.

adduser --uid 995 --gecos 'weewx' --system --group weewx

wget "http://www.weewx.com/downloads/released_versions/python3-weewx_${WEEWX_VERSION}_all.deb"
sha256sum -c < sums

# Expect dpkg to fail due to lack of prereqs
dpkg -i "python3-weewx_${WEEWX_VERSION}_all.deb" || true
apt-get -y --no-install-recommends -f install

rm "python3-weewx_${WEEWX_VERSION}_all.deb"

