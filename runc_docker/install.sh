yum -y install epel-release

yum -y update 
yum -y upgrade

yum -y group install "Development Tools"

yum install -y git libseccomp-devel vim wget

echo "Installing and configuring go"
GOPATH=/home/vagrant/go
wget https://golang.org/dl/go1.15.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz
rm go1.15.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.bashrc
echo "export GOPATH=$GOPATH" >> /home/vagrant/.bashrc
echo "Finished: Installing and configuring go"

echo "Installing and configuring runc"
su - vagrant <<EOF
source /home/vagrant/.bashrc
go get github.com/opencontainers/runc
cd $GOPATH/src/github.com/opencontainers/runc
make
sudo make install
EOF
echo "Finished: Installing and configuring runc"

echo "Installing and configuring docker"
yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
yum -y install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant
systemctl enable docker
systemctl restart docker
echo "Finished: Installing and configuring docker"

echo "Enabling user namespace"
echo 28633 > /proc/sys/user/max_user_namespaces
echo "Finished: Enabling user namespace"

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
