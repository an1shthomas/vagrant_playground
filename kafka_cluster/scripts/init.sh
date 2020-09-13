#!/bin/bash

# yum -y update && yum -y upgrade

yum -y install epel-release && \
  yum -y group install "Development Tools" && \
  yum -y install git vim wget libsecomp-devel yum-utils htop net-tools tree

echo "Downloading Kafka... ${KAFKA_VERSION}"

curl http://mirror.metrocast.net/apache/kafka/${KAFKA_SUB_VERSION}/${KAFKA_VERSION}.tgz -o /tmp/${KAFKA_VERSION}.tgz && \
  tar -xvzf /tmp/${KAFKA_VERSION}.tgz -C ${KAFKA_INSTALLATION_DIR}/

chown -R vagrant:vagrant ${KAFKA_INSTALLATION_DIR}/${KAFKA_VERSION}

# install java
su - vagrant <<EOF
# Install sdkman
curl -s "https://get.sdkman.io" | bash
source "/home/vagrant/.sdkman/bin/sdkman-init.sh"
sdk install java 14.0.2-zulu
EOF

# disable iptables (firewall)
systemctl disable firewalld

echo "Finished installing JDK and Kafka"
