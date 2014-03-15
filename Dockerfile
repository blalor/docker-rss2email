FROM blalor/supervised
MAINTAINER Brian Lalor <blalor@bravo5.org>

VOLUME /var/lib/rss2email

ADD src /tmp/src/
RUN /tmp/src/config.sh

