#!/bin/bash

echo "[TASK 1] Setting up ssh"
echo "----------------------------------------------------------------------"

cat > /home/vagrant/.ssh/config <<EOF
Host ubuntu*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
Host centos*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ''

for HOST in ubuntu1 ubuntu2 ubuntu3 centos1 centos2 centos3
do
  sshpass -p "vagrant" ssh-copy-id -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub $HOST
done

