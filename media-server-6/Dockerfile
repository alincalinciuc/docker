# nubomedia/media-server
#
# VERSION               0.0.2

FROM nubomedia/baseimage
MAINTAINER Alin CALINCIUC <alin.calinciuc@gmail.com>

# add google dns
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

RUN apt-get update -y

# Install needed packages
RUN apt-get install -q -y zip unzip default-jdk git maven apache2

RUN echo "RUN FROM HERE 2016 - Release 1"
RUN echo "Release 1.1 - kms6.4"

# Add Kurento Media Server repository and make sure the package repository is up to date
RUN echo "deb http://ubuntu.kurento.org trusty kms6" | sudo tee /etc/apt/sources.list.d/kurento.list
RUN wget -O - http://ubuntu.kurento.org/kurento.gpg.key | sudo apt-key add -
RUN apt-get update -y
RUN apt-get install kurento-media-server-6.0 -y

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add KMS config file
RUN rm -rf /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
ADD WebRtcEndpoint.conf.ini /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini

# Install KMS capabilities
RUN apt-get install kms-chroma-6.0 -y
RUN apt-get install kms-crowddetector-6.0 -y
RUN apt-get install kms-platedetector-6.0 -y
RUN apt-get install kms-pointerdetector-6.0 -y 
RUN apt-get install software-properties-common -y

# Install VTools Software
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F04B5A6F
RUN add-apt-repository "deb http://repository.nubomedia.eu/ trusty main"

# Run from here now
RUN echo "release 28 - v2"

# Add KMS6 Apt repository
RUN echo "deb http://ubuntuci.kurento.org/6.4.0 trusty kms6" > /etc/apt/sources.list.d/kurento.list
RUN apt-get update -y

RUN apt-get install nubo-ear-detector nubo-ear-detector-dev nubo-eye-detector nubo-eye-detector-dev nubo-face-detector nubo-face-detector-dev nubo-mouth-detector nubo-mouth-detector-dev nubo-nose-detector nubo-nose-detector-dev nubo-tracker nubo-tracker-dev nubo-vfence nubo-vfence-dev nubomotiondetector nubomotiondetector-dev -y

# Install VTT Software
RUN echo "deb [arch=amd64] http://ssi.vtt.fi/ubuntu trusty main" | tee -a /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install ar-markerdetector -y --force-yes
RUN apt-get install msdata -y --force-yes
RUN ldconfig

# Upgrade
#RUN apt-get upgrade -y

# Commands that need to start after boot
RUN mkdir -p /usr/local/bin/
ADD fix.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix.sh
ADD fix.conf /etc/init/

# Add monitoring for media elements and pipelines
RUN echo "Update sendstats 13.04.2016 v3"
RUN rm -rf ~/kms-monitoring-java
RUN cd ~/ && git clone https://github.com/usv-public/kms-monitoring-java.git

# copy sendstats to init scripts
RUN cp ~/kms-monitoring-java/scripts/sendstats /etc/init.d/sendstats
RUN chmod +x /etc/init.d/sendstats

RUN apt-get install monit -y
ADD monitrc /etc/monit/conf.d/monitrc

RUN apt-get install xinit -y
RUN apt-get install libsoup2.4-dev -y
RUN apt-get install xserver-xorg-video-dummy -y
RUN echo "export DISPLAY=:0" >> /etc/default/kurento-media-server-6.0

RUN rm -f /etc/logstash-forwarder.conf
ADD logstash-forwarder.conf /etc/logstash-forwarder.conf

EXPOSE 8888 22 25826

# Run after instace starts
CMD ["/sbin/init"]
