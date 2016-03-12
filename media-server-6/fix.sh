#!/bin/bash

sleep 5

instance_name=$(curl http://169.254.169.254/latest/meta-data/hostname)
HOSTNAME_MONITORING="HOSTNAMEMONITORING"
instance_name=${instance_name::-10}
sed -i -e "s/$HOSTNAME_MONITORING/$instance_name/g" /etc/collectd/collectd.conf
service collectd restart


# Remove ipv6 local loop until ipv6 is supported
instance_name_nova=$(curl http://169.254.169.254/latest/meta-data/hostname)
instance_name_local=$("hostname")
echo "" > /etc/hosts
echo "127.0.0.1 localhost $instance_name $instance_name_local" > /etc/hosts
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Restart kurento
service kurento-media-server-6.0 restart
service ssh restart
