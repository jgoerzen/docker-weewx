#!/bin/bash

set -e
set -x

cd /tmp/setup
wget "http://www.weewx.com/downloads/released_versions/weewx_${WEEWX_VERSION}-1_all.deb"
sha256sum -c < sums
dpkg -i "weewx_${WEEWX_VERSION}-1_all.deb" || apt-get -y --no-install-recommends -f install
rm "weewx_${WEEWX_VERSION}-1_all.deb"

