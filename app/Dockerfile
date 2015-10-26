# nubomedia/media-server
#
# VERSION               0.0.1

FROM ubuntu:14.04
MAINTAINER Alin CALINCIUC <alin.calinciuc@gmail.com>

# add google dns
# RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Add Kurento Media Server repository and make sure the package repository is up to date
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository ppa:kurento/kurento -y
RUN apt-add-repository http://ubuntu.kurento.org -y
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list
RUN apt-get -y update


# Install needed packages
RUN apt-get install -q -y zip unzip curl default-jdk zip wget git maven apache2


ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set suid to sudo
RUN chmod 4755 /usr/bin/sudo

# Install nodejs
#RUN add-apt-repository ppa:chris-lea/node.js -y
#RUN apt-get update -y
#RUN apt-get install nodejs -y
#RUN npm install -g bower

## WP4 T4.4
# Install packages
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F04B5A6F
RUN add-apt-repository "deb http://repository.nubomedia.eu/ trusty main" 
RUN apt-get update -y
RUN apt-get install nubo-face-detector nubo-face-detector-dev -y

RUN mkdir -p /tmp/NuboFaceJava
RUN cd /tmp/NuboFaceJava
RUN wget http://repository.nubomedia.eu/apps/NuboFaceJava.zip
RUN unzip -x NuboFaceJava.zip
RUN sh install.sh

RUN mkdir -p /tmp/NuboFaceProfileJava
RUN cd /tmp/NuboFaceProfileJava
RUN wget http://repository.nubomedia.eu/apps/NuboFaceProfileJava.zip
RUN unzip -x NuboFaceProfileJava.zip
RUN sh install.sh

RUN mkdir -p /tmp/NuboVfenceJava
RUN cd /tmp/NuboVfenceJava
RUN wget http://repository.nubomedia.eu/apps/NuboVfenceJava.zip
RUN unzip -x NuboVfenceJava.zip
RUN sh install.sh

EXPOSE 8888 22 8100 8102 8103 8104 8105 8106 8107 8108
ENTRYPOINT java -Dserver.port=8100 -Dapp.server.url=http://127.0.0.1:8100/ -Djava.security.egd=file:/dev/./urandom -Dkms.ws.uri=ws://80.96.122.65:8888/kurento -jar /var/lib/kurento/NuboFaceJava.jar

