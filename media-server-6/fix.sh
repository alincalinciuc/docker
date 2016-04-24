#!/bin/bash

sleep 5

instance_name=$(curl http://169.254.169.254/latest/meta-data/hostname)
HOSTNAME_MONITORING="HOSTNAMEMONITORING"
instance_name=${instance_name::-10}
sed -i -e "s/$HOSTNAME_MONITORING/$instance_name/g" /etc/collectd/collectd.conf
service collectd restart
sed -i -e "s/$HOSTNAME_MONITORING/$instance_name/g" /etc/logstash-forwarder.conf
service logstash-forwarder restart

# Remove ipv6 local loop until ipv6 is supported
instance_name_nova=$(curl http://169.254.169.254/latest/meta-data/hostname)
instance_name_local=$("hostname")
echo "" > /etc/hosts
echo "127.0.0.1 localhost $instance_name $instance_name_local" > /etc/hosts
echo "nameserver 8.8.8.8" > /etc/resolv.conf

export INSTANCE_NAME=$instance_name
export DISPLAY=:0

# Restart kurento
service kurento-media-server-6.0 restart
service ssh restart

# Start monitoring tools
service monit restart
service sendstats restart

# Xinit
cd ~/ && wget xpra.org/xorg.conf
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile /var/log/0.log -config ~/xorg.conf :0
