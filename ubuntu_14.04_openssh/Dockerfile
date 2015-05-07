# alincalinciuc/ubuntu_14.04_openssh
#
# VERSION               0.0.1

FROM ubuntu:14.04.2
MAINTAINER Alin CALINCIUC <alin.calinciuc@gmail.com>

# add google dns
# RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

# install openssh server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
#RUN echo 'root:Parola123' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install needed packages
RUN apt-get install -q -y zip unzip curl

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# OpenStack metadata fixes
ADD fix_docker_on_openstack.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix_docker_on_openstack.sh

EXPOSE 22
ENTRYPOINT /usr/local/bin/fix_docker_on_openstack.sh | /usr/sbin/sshd -D
