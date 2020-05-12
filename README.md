# Graylog
Fast launch your own graylog instance via docker
---
## What is Graylog?
---
Graylog is a centralized logging solution that allows the user to aggregate and search through logs. It provides a powerful query language, a processing pipeline for data transformation, alerting abilities and much more. It is fully extensible through a REST API.

## About this repository
---
Using this repo you can launch your own instance graylog server in docker in a few minutes.
Instance consist of:
* Graylog container;
* Mongodb container;
* ES container;
* Cerbot container for work with elasticsearch;
## How to use
---
1. Clone the repository
    ```
    git clone git@github.com:malinkinsa/Graylog.git
    ```
2. Make folders es are readable for **elasticsearch** user:
    ```
    chmod g+rwx es
    chgrp 1000 es
    ```
3. Change permissions for journal directory:
    ```
    chown -R 1100:1100 journal/
    ```
