#!/bin/bash

# create key if it is not there
[ -f /vagrant/id_rsa ] || {
  ssh-keygen -t rsa -f /vagrant/id_rsa -q -N ''
}

# deploy key
[ -f /home/vagrant/.ssh/id_rsa ] || {
  cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
  chmod 0600 /home/vagrant/.ssh/id_rsa
}

# allow ssh passwordless
grep 'vagrant@' ~/.ssh/authorized_keys &>/dev/null || {
  cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
}

cat > ~/.ssh/config <<EOF
Host node*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
Host ubuntu*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
Host centos*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
