#!/bin/bash

yum -y install wget vim

# create a new user and download prometheus
useradd -m -s /bin/bash prometheus

# run as prometheus user
su - prometheus -c "wget https://github.com/prometheus/prometheus/releases/download/v2.20.0/prometheus-2.20.0.linux-amd64.tar.gz;tar -xf prometheus-2.20.0.linux-amd64.tar.gz;mv prometheus-2.20.0.linux-amd64/ prometheus/;mkdir -p ~/prometheus/data"

# configure prometheus as a systemd service
cd /etc/systemd/system/
cat <<EOF >prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Restart=on-failure

#Change this line if you download the
#Prometheus on different path user
ExecStart=/home/prometheus/prometheus/prometheus \
  --config.file=/home/prometheus/prometheus/prometheus.yml \
  --storage.tsdb.path=/home/prometheus/prometheus/data

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

# start the prometheus service and enable it to launch everytime at system startup
systemctl start prometheus
systemctl enable prometheus
systemctl status prometheus

echo "Finished installing prometheus"
