# MongoDB

- [MongoDB](#mongodb)
  - [MongoDB Backup/Restore](#mongodb-backuprestore)
    - [Backup](#backup)
    - [Restore](#restore)


## MongoDB Backup/Restore
### Backup
- Add volume for backup to container:
  ```
  mongodb:
    image: mongo:4
    container_name: mongodb
    networks:
      - graylog
    mem_limit: 1g
    volumes:
     - ./mongo_data:/data/db
     - ./mongo_backup:/data/backup
  ```
- Restart MongoDB container;
- Create backup (if you use it in script - change from ```exec -ti``` to ```exec -i``` ):
  ```
  docker exec -ti mongodb sh -c 'mongodump -d graylog --gzip -o backup.gz'
  ```
### Restore
- Copy backup to mount volume;
- Start the restore:
  ```
  docker exec -ti mongodb sh -c 'mongorestore -d graylog --gzip backup.gz'
  ```
