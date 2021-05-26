# Graylog

Fast launch your own graylog instance via docker
---
## What is Graylog
---
Graylog is a centralized logging solution that allows the user to collect and search through logs. It provides a powerful query language, a processing pipeline for data transformation, alerting abilities and much more. It is fully extensible through a REST API.

## About this repository
---
Using this repo you can launch your own instance graylog server in docker.
Instance consist of:
*   Graylog container;
*   Mongodb container;
*   ES container;
*   Cerbot container for work with elasticsearch;
## How to use
---
1.  Clone the repository
    ```
    git clone git@github.com:malinkinsa/Graylog.git
    ```

2.  Make folders es are readable for **elasticsearch** user:
    ```
    chmod g+rwx data
    chgrp 1000 data
    ```

3.  Change permissions for journal directory:
    ```
    chown -R 1100:1100 journal/
    ```

4.  Specify next environments in `.env` file: _uri_; _admin_password_; _secret_; _timezone_; _smtp_; _elasticsearch_shards_; _elasticsearch_replicas_; 
    *   uri - specify your server address;
    *   admin_password - specify password for default admin account in SHA2; You can generate it with this command: 
        ```
        echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1
        ```
    *   secret - specify a random secret for your graylog instance; You can generate it with this command:
        ```
        pwgen -N 1 -s 18
        ```
    *   timezone - specify a time zone of your graylog instance. [List of valid time zones](https://www.joda.org/joda-time/timezones.html)
5.  Launch all containers:
    ```
    docker-compose up -d
    ```
6.  Open http://<your ip/dns>:9000 to access your graylog instance.

7.  Comment next two string in docker-compose file:
    ```
    - GRAYLOG_ELASTICSEARCH_SHARDS=${elasticsearch_shards}
    - GRAYLOG_ELASTICSEARCH_REPLICAS=${elasticsearch_replicas}
    ``` 
8.  Pull out node-id file from container and mount it:
    ```
    sudo docker cp graylog:/usr/share/graylog/data/config/node-id .
    ```
9.  Mount it to container. Uncomment this line:
    ```
    - ./node-id:/usr/share/graylog/data/config/node-id
    ```
10. Relaunch graylog:
    ```
    docker-compose up -d
    ```

## To-Do
---

*   Add Nginx as a Reverse-Proxy;
*   Backup Mongodb;
*   Authentication in mongodb;
*   Multinode graylog setup;
*   ES cluster with x-pack;
