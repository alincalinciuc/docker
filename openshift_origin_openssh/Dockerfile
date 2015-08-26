FROM     alincalinciuc/openshift_origin_openssh
EXPOSE 22
ENTRYPOINT /usr/local/bin/fix_docker_on_openstack.sh | /usr/sbin/sshd -D
