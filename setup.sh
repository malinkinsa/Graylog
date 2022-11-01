#!/bin/bash

# Checking root rights
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# Preparing graylog .env file
echo Preparing graylog .env file
echo -----------------------

echo Enter server ip address
read -p 'server ip:' IP

echo Enter graylog Admin password: 
read -p 'password: ' ADM_PWD
PWD_SHA=$(echo $ADM_PWD | head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1)

echo Enter timezone '(Canonical ID)' Full list available at https://www.joda.org/joda-time/timezones.html
read -p '' TZ

if ! [ -x "$(command -v pwgen)" ]; then
    echo Enter Graylog secret '(at least 16 symbol)'
    read -p '' SECRET
else
    SECRET=$(pwgen -N 1 -s 18)
fi

echo .env file created with next parameters:
echo
echo 
echo 
cat <<EOF | tee .env 
uri=http://$IP:9000/
es_host=http://elasticsearch:9200
mongo_uri=mongodb://mongodb:27017/graylog
admin_password=$PWD_SHA
secret='$SECRET'
timezone=$TZ
EOF
echo
echo 
echo

# Preparing Graylog journal folder
mkdir journal && chown -R 1100:1100 journal/

# Preparing ElasticSearch folder
mkdir data && chmod g+rwx data && chown 1000:1000 data

# Preparing docker images
echo Pulling docker images
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.10.0
docker pull graylog/graylog:4.3.8
docker pull mongo:4