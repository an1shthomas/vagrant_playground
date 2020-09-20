#!/bin/bash

echo "starting mongodb server"

systemctl enable mongod
systemctl start mongod

echo "finished initializing"
