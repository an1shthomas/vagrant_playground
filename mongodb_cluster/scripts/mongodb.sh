#!/bin/bash
systemctl enable mongod
systemctl stop mongod

MONGOD_CONF_FILE="/etc/mongod.conf"
tee -a $MONGOD_CONF_FILE <<-"EOF"
replication:
  oplogSizeMB: 64
  replSetName: rs-example
EOF

perl -pi -e 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' $MONGOD_CONF_FILE

#mv /vagrant/config/mongod.conf /etc/mongod.conf
#chown mongod:mongod /etc/mongod.conf

mkdir -p /data/db
chown -R mongod:mongod /data/

systemctl start mongod

if [[ $1 -eq 1 ]]; then
echo "Initiating the replica set"
mongo << "EOF"
rs.initiate( {
   _id : "rs-example",
   members: [
      { _id: 0, host: "mongodb1:27017" },
      { _id: 1, host: "mongodb2:27017" },
      { _id: 2, host: "mongodb3:27017" }
   ]
})
EOF
fi
