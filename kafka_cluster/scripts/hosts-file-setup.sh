#!/bin/bash

echo "hosts file setup..."

sudo echo "10.30.3.2 vg-zk1" | sudo tee -a /etc/hosts 
sudo echo "10.30.3.3 vg-zk2" | sudo tee -a /etc/hosts 
sudo echo "10.30.3.4 vg-zk3" | sudo tee -a /etc/hosts 


sudo echo "10.30.3.20 vg-br1" | sudo tee -a /etc/hosts 
sudo echo "10.30.3.30 vg-br2" | sudo tee -a /etc/hosts 
sudo echo "10.30.3.40 vg-br3" | sudo tee -a /etc/hosts 
