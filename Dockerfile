FROM ubuntu:latest
MAINTAINER Kaisar Arkhan (Yuki) <ykno@protonmail.com>

ENV PLANET_VERSION=2.0 DEBIAN_FRONTEND=noninteractive TERM=dumb

# Update repository
RUN apt-get update

# Install required packages
RUN apt-get install -y python2.7-minimal python3-minimal python3-bsddb3 curl bzip2 lighttpd cron unzip

# locale
RUN apt-get update && \
    apt-get install -y locales && \
    sed -i -e 's/# tr_TR.UTF-8 UTF-8/tr_TR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANG tr_TR.UTF-8
ENV LC_ALL tr_TR.UTF-8

# Download planetplanet
RUN mkdir /planetplanet && \
    curl -k https://codeload.github.com/bmericc/planetplanet/tar.gz/refs/tags/2.0 \
         -o /tmp/planetplanet.tar.gz && \
    tar xfzv /tmp/planetplanet.tar.gz --strip 1 -C /planetplanet && \
    rm -rfv /tmp/planetplanet.tar.gz && \
    mkdir -p /planetplanet/gezegen /planetplanet/gezegen-lkd /planetplanet/gezegen-topluluk /planetplanet/gezegen-kisisel /planetplanet/gezegen-planet && \
    mkdir -p /planetplanet/output /planetplanet/cache && \
    rm -rf /var/www/html && ln -s /planetplanet/output /var/www/html

# Add update script
ADD update-page.sh /usr/bin/update-page

# Add crontab
ADD crontab /etc/cron.d/autoupdate

# Make myplanet into a volume
VOLUME /planetplanet

# Add example planetplanet configuration
ADD gezegen /planetplanet/gezegen
ADD gezegen-lkd /planetplanet/gezegen-lkd
ADD gezegen-topluluk /planetplanet/gezegen-topluluk
ADD gezegen-kisisel /planetplanet/gezegen-kisisel
ADD gezegen-planet /planetplanet/gezegen-planet

RUN cd /planetplanet/ && ls

# Grant execution rights to cron job and update script
RUN chmod 0644 /etc/cron.d/autoupdate && \
    chmod 0755 /usr/bin/update-page


# Expose port 80
EXPOSE 80

# Update and start cron daemon + lighttpd
CMD update-page && cron && lighttpd -D -f /etc/lighttpd/lighttpd.conf
