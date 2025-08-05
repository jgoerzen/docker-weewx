#!/bin/bash

set -e
set -x

cd /tmp/setup

# There is a bug in how usermod is called in the weewx postinst to add the weewx
# user to the weewx group.  Also we need constant UIDs for Docker, so set it up here.

adduser --uid 995 --gecos 'weewx' --system --group weewx

wget "http://www.weewx.com/downloads/released_versions/python3-weewx_${WEEWX_VERSION}-3_all.deb"
sha256sum -c < sums

# Expect dpkg to fail due to lack of prereqs
#
# Due to a bug, usermod is not going to work.
#
# Used to just run:
#
# dpkg -i "python3-weewx_${WEEWX_VERSION}-1_all.deb" || apt-get -y --no-install-recommends -f install
#
# That dpkg -i is expected to fail due to missing deps.  Split it out to handle this
# weird usermod call.
#
# Bug is https://github.com/weewx/weewx/issues/952
dpkg -i "python3-weewx_${WEEWX_VERSION}-1_all.deb" || true
sed -i 's/usermod/echo/g' /var/lib/dpkg/info/weewx.postinst
apt-get -y --no-install-recommends -f install

rm "python3-weewx_${WEEWX_VERSION}-1_all.deb"

