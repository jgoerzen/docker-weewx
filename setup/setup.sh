#!/bin/bash

set -e
set -x

cd /tmp/setup
wget "http://www.weewx.com/downloads/released_versions/python3-weewx_${WEEWX_VERSION}-1_all.deb"
sha256sum -c < sums
dpkg -i "python3-weewx_${WEEWX_VERSION}-1_all.deb" || apt-get -y --no-install-recommends -f install
rm "python3-weewx_${WEEWX_VERSION}-1_all.deb"

