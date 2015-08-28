#!/bin/bash

sleep 5

# Get public keys from meta-data server
# Create .ssh directory for root
if [ ! -d /root/.ssh ]; then
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
fi
# Fetch public key 
ATTEMPTS=30
FAILED=0
if [ ! -f /root/.ssh/authorized_keys ]; then
    wget http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key -O /tmp/metadata-key -o /var/log/metadata_svc_bugfix.log
    if [ $? -eq 0 ]; then
        cat /tmp/metadata-key >> /root/.ssh/authorized_keys
        chmod 0600 /root/.ssh/authorized_keys
        # restorecon /root/.ssh/authorized_keys
        rm -f /tmp/metadata-key
        echo "Successfully retrieved public key from instance metadata" >> /var/log/metadata_svc_bugfix.log
    fi
fi
sync

# Add instance name to /tmp/hosts
instance_name=$(curl http://169.254.169.254/latest/meta-data/hostname)
sed -i " 1 s/.*/& $instance_name/" /etc/hosts

# Get user-data and run them
curl -o /tmp/user-data.sh http://169.254.169.254/2009-04-04/user-data
chmod +x /tmp/user-data.sh
cd /tmp && ./user-data.sh


