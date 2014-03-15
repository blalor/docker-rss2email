#!/bin/bash

set -e -x

cd /tmp/src

mv r2e.sh /usr/local/bin/
mv logrotate-r2e.conf /etc/logrotate.d/r2e
mv cron-r2e /etc/cron.d/r2e

mv prepare-directories.sh /usr/local/bin/
mv program-prepare-directories.conf /etc/supervisor.d/

groupadd -g 600 rss2email
useradd -g rss2email -u 600 -r rss2email

yum install -y centos-release-SCL
yum install -y python33-python python33-python-setuptools

. /opt/rh/python33/enable 

easy_install pip
pip install rss2email feedparser html2text

touch /var/log/rss2email.log
chown rss2email:rss2email /var/log/rss2email.log

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
