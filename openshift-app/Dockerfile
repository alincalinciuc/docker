FROM ubuntu-upstart:14.04

MAINTAINER Alin CALINCIUC <alin.calinciuc@usv.ro>

# Update repository
RUN apt-get clean all
RUN apt-get -y update

# Install packages
RUN apt-get install wget curl -y

# Permit ssh key authentication
RUN sed -ri 's/#?RSAAuthentication\s+.*/RSAAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

RUN echo 'root:nub0m3d1@' | chpasswd

# Add Google nameserver
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Install collectd
RUN apt-get install collectd -y; exit 0
ADD collectd.conf /etc/collectd/

# OpenStack metadata fixes & other commands that need to start after boot
RUN mkdir -p /usr/local/bin/
ADD fix_docker_on_openstack.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fix_docker_on_openstack.sh

# Add init script for fixing docker on OpenStack
ADD fix_docker_on_openstack.conf /etc/init/

# Expose default ports
EXPOSE 22 8888 8100 8102 8103 8104 8105 8106 8107 8108

# Run after instace starts
CMD ["/sbin/init"]
