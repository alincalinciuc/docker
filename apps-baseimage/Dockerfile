FROM nubomedia/apps-baseimage:v1

MAINTAINER alin.calinciuc@gmail.com

## Install Collectd
RUN apk --update add collectd
ADD collectd.conf /etc/collectd/

## Install logstash-forwarder
COPY logstash-forwarder /usr/bin/logstash-forwarder
RUN chmod +x /usr/bin/logstash-forwarder
RUN apk --update add openssl
RUN wget https://www.dropbox.com/s/5uu95vg6t0k1b92/logstash-forwarder.crt?dl=0 -O /tmp/logstash-forwarder.crt
RUN mkdir -p /etc/pki/tls/certs
RUN cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/

# Add logstash config file
ADD logstash-forwarder.conf /etc/logstash-forwarder.conf

WORKDIR /var/cache/logstash-forwarder

ENTRYPOINT /usr/bin/logstash-forwarder -config=/etc/logstash-forwarder.conf | /usr/sbin/collectd
