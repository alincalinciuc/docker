# nubomedia/media-server
#
# VERSION               0.0.1

FROM ubuntu:14.04.2
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

# Install openssh server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Install needed packages
RUN apt-get install -q -y zip unzip curl default-jdk wget git maven apache2

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# OpenStack metadata fixes
ADD fix_docker_on_openstack.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix_docker_on_openstack.sh

# Set suid to sudo
RUN chmod 4755 /usr/bin/sudo

# Install nodejs
RUN add-apt-repository ppa:chris-lea/node.js -y
RUN apt-get update -y
RUN apt-get install nodejs -y
RUN npm install -g bower

# Install Kurento Media Server
RUN apt-get update -y
RUN wget -qO - http://ubuntu.kurento.org/kurento.gpg.key | sudo apt-key add -
RUN apt-get install kurento-media-server -y --force-yes

# Install Naevatec/URJC Kurento Media Server Modules
RUN apt-get install kms-background-extractor -y --force-yes
RUN apt-get install kms-chroma -y --force-yes
RUN apt-get install kms-crowddetector -y --force-yes
RUN apt-get install kms-face-segmentator -y --force-yes
RUN apt-get install kms-platedetector -y --force-yes
RUN apt-get install kms-pointerdetector -y --force-yes
RUN apt-get install kms-markerdetector -y --force-yes

# Install Naevatec/URJC Java Tutorials
RUN mkdir -p /tmp/kurento-magic-mirror && cd /tmp/kurento-magic-mirror && wget http://builds.kurento.org/dev/latest/tutorials/kurento-magic-mirror.zip && unzip kurento-magic-mirror.zip && sudo ./bin/install.sh
RUN mkdir -p /tmp/kurento-pointerdetector && cd /tmp/kurento-pointerdetector && wget http://builds.kurento.org/dev/latest/tutorials/kurento-pointerdetector.zip && unzip kurento-pointerdetector.zip && sudo ./bin/install.sh
RUN mkdir -p /tmp/kurento-chroma && cd /tmp/kurento-chroma && wget http://builds.kurento.org/dev/latest/tutorials/kurento-chroma.zip && unzip kurento-chroma.zip && sudo ./bin/install.sh
RUN mkdir -p /tmp/kurento-crowddetector && cd /tmp/kurento-crowddetector && wget http://builds.kurento.org/dev/latest/tutorials/kurento-crowddetector.zip && unzip kurento-crowddetector.zip && sudo ./install.sh
RUN mkdir -p /tmp/kurento-platedetector && cd /tmp/kurento-platedetector && wget http://builds.kurento.org/dev/latest/tutorials/kurento-platedetector.zip && unzip kurento-platedetector.zip && sudo ./bin/install.sh

# Install VT Software
#RUN cd /tmp/ && wget http://vps.dnsvideo.net:88/nubomedia_install_vca_elements.sh && chmod +x nubomedia_install_vca_elements.sh && sudo ./nubomedia_install_vca_elements.sh

# Disable IPV6
RUN sed -i '$ a\net.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1' /etc/sysctl.conf

# Enable autostart of Kurento Media Server on boot
#update-rc.d kurento-media-server defaults

# Enable autostart of Demonstrators
#update-rc.d kurento-magic-mirror defaults
#update-rc.d kurento-pointerdetector defaults
#update-rc.d kurento-chroma defaults
#update-rc.d kurento-crowddetector defaults
#update-rc.d kurento-platedetector defaults
#update-rc.d kurento-magic-mirror defaults

# Create Kurento directory if it does not exist
RUN mkdir -p /etc/kurento/

EXPOSE 22
ENTRYPOINT /usr/local/bin/fix_docker_on_openstack.sh | /usr/sbin/sshd -D
