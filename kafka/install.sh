yum -y update && yum -y upgrade

yum -y install epel-release && \
  yum -y group install "Development Tools" && \
  yum -y install git vim wget libsecomp-devel yum-utils htop net-tools tree

su - vagrant <<EOF
# Install sdkman
curl -s "https://get.sdkman.io" | bash
source "/home/vagrant/.sdkman/bin/sdkman-init.sh"
sdk install java 14.0.2-zulu
EOF

# Install kafka
echo "Downloading Kafka"
KAFKA_VERSION=kafka_2.12-2.6.0
curl http://mirror.metrocast.net/apache/kafka/2.6.0/${KAFKA_VERSION}.tgz -o /tmp/${KAFKA_VERSION}.tgz && tar -xvzf /tmp/${KAFKA_VERSION}.tgz -C /opt/

chown -R vagrant:vagrant /opt/${KAFKA_VERSION}

echo "Configuring vimrc"
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
echo "Finished: configuring vimrc"

echo "Finished provisioning"
