#!/bin/bash

# Remove ipv6 local loop until ipv6 is supported
instance_name_nova=$(curl http://169.254.169.254/latest/meta-data/hostname)
IFS='.' read -ra array <<< "$instance_name_nova"
instance_name=${array[0]}
instance_name_local=$("hostname")
echo "" > /etc/hosts
echo "127.0.0.1 localhost $instance_name $instance_name_local" > /etc/hosts
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Restart kurento
service kurento-media-server-6.0 restart

HOSTNAME_MONITORING="HOSTNAMEMONITORING"
sed -i -e "s/$HOSTNAME_MONITORING/$instance_name/g" /etc/collectd/collectd.conf
service collectd restart
