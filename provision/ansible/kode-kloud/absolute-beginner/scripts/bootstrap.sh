#!/bin/bash

echo "[TASK 1]  Enable SSH password authentication"
echo "----------------------------------------------------------------------"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd
