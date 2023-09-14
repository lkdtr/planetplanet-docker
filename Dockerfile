FROM ubuntu:latest
MAINTAINER Kaisar Arkhan (Yuki) <ykno@protonmail.com>

ENV PLANET_VERSION=2.0 DEBIAN_FRONTEND=noninteractive TERM=dumb

# Update repository
RUN apt-get update

# Install required packages
RUN apt-get install -y python2.7-minimal python3-minimal python3-bsddb3 curl bzip2 lighttpd cron unzip

# Download planetplanet
RUN mkdir /planetplanet && \
    curl -k https://codeload.github.com/lkdtr/gezegen/zip/refs/heads/master \
         -o /tmp/planetplanet.zip && \
    unzip /tmp/planetplanet.zip -d /planetplanet && \
    rm -rfv /tmp/planetplanet.zip && \
    mkdir -p /planetplanet/output /planetplanet/cache /planetplanet/myplanet && \
    rm -rf /var/www/html && ln -s /planetplanet/output /var/www/html

# Add update script
ADD update-page.sh /usr/bin/update-page

# Add crontab
ADD crontab /etc/cron.d/autoupdate

# Add example planetplanet configuration
ADD myplanet /planetplanet/myplanet

# Grant execution rights to cron job and update script
RUN chmod 0644 /etc/cron.d/autoupdate && \
    chmod 0755 /usr/bin/update-page

# Make myplanet into a volume
VOLUME /planetplanet/myplanet

# Expose port 80
EXPOSE 80

# Update and start cron daemon + lighttpd
CMD update-page && cron && lighttpd -D -f /etc/lighttpd/lighttpd.conf
