#!/bin/bash

# Preparing graylog .env file
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

echo Enter server ip address
read -p 'server ip:' IP

echo Enter graylog Admin password:
read -p 'password: ' ADM_PWD
PWD_SHA=$(echo $ADM_PWD | sha256sum | cut -d" " -f1)

echo Enter timezone '(Canonical ID)' Full list available at https://www.joda.org/joda-time/timezones.html
read -p '' TZ

if ! [ command -v pwgen &> /dev/null ]; then
    echo Enter Graylog secret '(at least 16 symbol)'
    read -p '' SECRET
else
    SECRET=$(pwgen -N 1 -s 18)
fi

echo .env file created with next parameters:
cat <<EOF | tee ../.env 
uri=http://$IP:9000/
es_host=http://elasticsearch:9200
admin_password=$PWD_SHA
secret='$SECRET'
timezone=$TZ
EOF

# Make a mongodb replica set for graylog
KEYFILE=../mongodb_config/mongodb-keyfile

if [ -f $KEYFILE ]; then
    echo "MongoDB Keyfile exists"
else
    echo "Creating a mongodb-keyfile"
    openssl rand -base64 741 > ../mongodb_config/mongodb-keyfile
    chown 1001:1001 ../mongodb_config/mongodb-keyfile
    chmod 600 ../mongodb_config/mongodb-keyfile
fi

docker-compose up -d mongodb
sleep 15
docker exec -i mongodb bash -c 'mongo < /data/mongodb_config/replica.js'

# Preparing ElasticSearch folder
chmod g+rwx data
chown 1000:1000 data

docker-compose up -d