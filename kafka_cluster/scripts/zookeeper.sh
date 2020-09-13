#!/bin/bash

ZOOKEEPER_DATA_DIR=/tmp/zookeeper

if [ ! -d ${ZOOKEEPER_DATA_DIR} ]; then
  echo "Creating zookeeper data dir.. ${ZOOKEEPER_DATA_DIR}"
  mkdir ${ZOOKEEPER_DATA_DIR}
  echo $1 > ${ZOOKEEPER_DATA_DIR}/myid
fi

echo "Starting zookeeper$1"
# 0<&- closes the file descriptor 0 (standard input)
# &> redirects both stdout and stderr 
nohup $KAFKA_HOME/bin/zookeeper-server-start.sh /vagrant/config/zookeeper.properties 0<&- &> /tmp/zookeeper.log &
sleep 2
