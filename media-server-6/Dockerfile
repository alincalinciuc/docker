# nubomedia/media-server
#
# VERSION               0.0.2

FROM alincalinciuc/nubomedia
MAINTAINER Alin CALINCIUC <alin.calinciuc@gmail.com>

# add google dns
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

RUN apt-get update -y
# Install needed packages
RUN apt-get install -q -y zip unzip default-jdk git maven apache2; exit 0

# Add Kurento Media Server repository and make sure the package repository is up to date
RUN echo "deb http://ubuntu.kurento.org trusty kms6" | sudo tee /etc/apt/sources.list.d/kurento.list
RUN wget -O - http://ubuntu.kurento.org/kurento.gpg.key | sudo apt-key add -
RUN apt-get update -y
RUN apt-get install kurento-media-server-6.0 -y; exit 0 

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# install stats script
RUN cd ~/ && git clone http://80.96.122.50/usv/kms-monitoring-java.git

# Add KMS config file
RUN rm -rf /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
ADD WebRtcEndpoint.conf.ini /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini

EXPOSE 8888 22 25826
