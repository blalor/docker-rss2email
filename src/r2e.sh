#!/bin/bash

set -e

if [ "$( id -n -u )" != "rss2email" ] ; then
    echo "must run as 'rss2email' user"
    exit 1
fi

. /opt/rh/python33/enable 

r2e_dir="/var/lib/rss2email"

r2e \
    --config ${r2e_dir}/rss2email.cfg \
    --data   ${r2e_dir}/rss2email.json \
    "$@"
