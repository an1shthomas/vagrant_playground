#!/bin/bash

# create ssh key if it is not there
[ -f /vagrant/id_rsa ] || {
  ssh-keygen -t rsa -f /vagrant/id_rsa -q -N ''
} 

# deploy/copy the key
[ -f /home/vagrant/.ssh/id_rsa ] || {
  cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
  chmod 0600 /home/vagrant/.ssh/id_rsa
}

# allow ssh passwordless
grep 'vagrant@' /home/vagrant/.ssh/authorized_keys &> /dev/null || {
  cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
}

cat > /home/vagrant/.ssh/config <<EOF
Host ubuntu*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
Host centos*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
