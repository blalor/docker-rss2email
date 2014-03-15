Docker image for [rss2email][rss2email]

Runs `rss2email` every hour via cron.  Config is stored in the
`/var/lib/rss2email` volume.

## setup

First, start the container.  It requires a data volume, and you'll have to
modify the config by hand, so just mount a local directory:

    docker run \
        --detach \
        --volume=/path/to/data:/var/lib/rss2email \
        --name=rss2email \
        blalor/rss2email

Now create an initial configuration; you must provide the `rss2email` user to
invoke the command:

    docker run \
        --volumes-from=rss2email \
        --user=rss2email \
        blalor/rss2email \
        r2e.sh new <email_address>

Modify the config so that it sends email via SMTP instead of sendmail (which
won't work inside the container); in `/path/to/data/rss2email.cfg` set the
following properties:

    from = your_email_address
    email-protocol = smtp
    smtp-server = 'some.server:25'

If you need to use SSL or provide authentication, see the available options
[here][config-opts].
    
Add an RSS feed:

    docker run \
        --volumes-from=rss2email \
        --user=rss2email \
        blalor/rss2email \
        r2e.sh add docker http://blog.docker.io/feed/

Do an initial run to make sure it works:

    docker run \
        --volumes-from=rss2email \
        --user=rss2email \
        blalor/rss2email \
        r2e.sh run

And from now on, feed updates will be sent every hour!

[rss2email]: https://github.com/wking/rss2email
[config-opts]: https://github.com/wking/rss2email/blob/master/rss2email/config.py
