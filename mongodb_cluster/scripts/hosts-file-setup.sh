#!/bin/bash

echo "hosts file setup"

sudo echo "10.50.3.10 mongodb1" | sudo tee -a /etc/hosts
sudo echo "10.50.3.20 mongodb2" | sudo tee -a /etc/hosts
sudo echo "10.50.3.30 mongodb3" | sudo tee -a /etc/hosts
