#!/bin/bash

echo "Starting broker$1"
nohup $KAFKA_HOME/bin/kafka-server-start.sh -daemon /vagrant/config/server$1.properties
