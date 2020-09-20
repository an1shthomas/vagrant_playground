#!/bin/bash

echo "updating packages"
yum -y update && yum -y upgrade
yum -y install epel-release && \
  yum -y group install "Development Tools" && \
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

echo "configurinbg vimrc"
cat <<EOF>/home/vagrant/.vimrc
" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
EOF

echo "finished setup"
