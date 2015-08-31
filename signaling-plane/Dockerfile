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
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list
RUN apt-get -y update

# Install openssh server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Install needed packages
RUN apt-get install -q -y gradle zip unzip curl java7-jdk wget git maven apache2

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# OpenStack metadata fixes
ADD fix_docker_on_openstack.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix_docker_on_openstack.sh

# Get SIP from git and compile it
RUN git clone http://git.nubomedia.eu/alice.cheambe/signaling-plane.git && cd signaling-plane && ./compile_modules
RUN echo "TODO: configure signaling plane in nubomedia_signaling_plane.json"
RUN echo "TODO: configure clustering if needed"
RUN echo "starting signaling plane"

# Disable IPV6
RUN sed -i '$ a\net.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1' /etc/sysctl.conf

EXPOSE 22 5060
ENTRYPOINT /usr/local/bin/fix_docker_on_openstack.sh | /usr/sbin/sshd -D
