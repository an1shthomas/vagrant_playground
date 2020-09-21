#!/bin/bash

echo "Updating packages"
# yum -y update && yum -y upgrade
yum -y install epel-release && \
  yum -y group install "Development Tools" && \
  yum -y install openssl openssl-devel && \
  yum -y install git vim wget yum-utils htop net-tools tree

echo "configuring the package"

cat <<EOF>/etc/yum.repos.d/mongodb-org-4.4.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

echo "install mongodb packages"
yum install -y mongodb-org

# disable iptables (firewall)
systemctl disable firewalld

echo "finished setup"
