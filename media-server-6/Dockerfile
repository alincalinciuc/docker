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

#RUN apt-get --force-yes remove libpam-systemd policykit-1 colord policykit-1-gnome -y
# Install KMS capabilities
RUN apt-get install kms-chroma-6.0 -y; exit 0
RUN apt-get install kms-crowddetector-6.0 -y; exit 0
RUN apt-get install kms-platedetector-6.0 -y; exit 0
RUN apt-get install kms-pointerdetector-6.0 -y; exit 0 
RUN apt-get install software-properties-common -y; exit 0
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F04B5A6F
RUN add-apt-repository "deb http://repository.nubomedia.eu/ trusty main"; exit 0
RUN apt-get update -y; exit 0
RUN apt-get install nubo-ear-detector nubo-ear-detector-dev nubo-eye-detector nubo-eye-detector-dev nubo-face-detector nubo-face-detector-dev nubo-mouth-detector nubo-mouth-detector-dev nubo-nose-detector nubo-nose-detector-dev nubo-tracker nubo-tracker-dev nubo-vfence nubo-vfence-dev nubomotiondetector nubomotiondetector-dev -y; exit 0

# Commands that need to start after boot
RUN mkdir -p /usr/local/bin/
ADD fix.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix.sh

# Add init script for fixing docker on OpenStack
ADD fix.conf /etc/init/

EXPOSE 8888 22 25826
