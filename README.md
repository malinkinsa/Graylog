# Graylog

Fast launch your own graylog instance via docker  
- [Graylog](#graylog)
  - [What is Graylog](#what-is-graylog)
  - [About this repository](#about-this-repository)
  - [How to use](#how-to-use)
  - [To-Do](#to-do)

## What is Graylog

[Graylog](https://www.graylog.org/) is a centralized logging solution that allows the user to collect and search through logs. It provides a powerful query language, a processing pipeline for data transformation, alerting abilities and much more. It is fully extensible through a REST API.

## About this repository

Using this repo you can launch your own instance graylog server in docker.
Instance consist of:
*   Graylog v5.0 container;
*   Mongodb v6.0 container;
*   ElasticSearch v7.10.2 container;

## How to use

1.  Clone the repository
    ```
    git clone git@github.com:malinkinsa/Graylog.git && cd Graylog/
    ```

2.  Make `seput.sh` executable
    ```
    sudo chmod +x setup.sh
    ```

3. To configure, run setup.sh from the root or with sudo and follow it
To configure, run setup.sh from the root or with sudo and follow it
    ```
    sudo ./setup.sh
    ```

4. Launch containers
   ```
   docker-compose up -d
   ```
5. Open in browser `http://$server_ip:9000`

6. If you want to save Inputs config after container re creation or update:
   1. Copy node-id from inside container to current folder
      ```
      docker cp graylog:/usr/share/graylog/data/config/node-id .
      ```
   2. Uncomment next string in `docker-compose.yml`
   
      `#- ./node-id:/usr/share/graylog/data/config/node-id`
   3. Restart Graylog container
      ```
      docker-compose up -d graylog
      ```

## To-Do

- [x] [Add Nginx as a Reverse-Proxy](docs/nginx.md); 
- [x] [Backup Mongodb](docs/mongodb.md);
- [ ] Mongodb in replicaset; <i>Will be when switching to graylog v5</i>
- [ ] ES cluster with x-pack;
