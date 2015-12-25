#cloud-config
rancher:
  services:
    rancher-server:
      image: rancher/server
      ports:
      - 8080:8080
      restart: always
      environment:
        - CATTLE_DB_CATTLE_MYSQL_HOST="${rancher_rds_instance_address}"
        - CATTLE_DB_CATTLE_MYSQL_PORT="${rancher_rds_instance_port}"
        - CATTLE_DB_CATTLE_MYSQL_NAME="${rancher_rds_database_name}"
        - CATTLE_DB_CATTLE_USERNAME="${rancher_rds_database_username}"
        - CATTLE_DB_CATTLE_PASSWORD="${rancher_rds_database_password}"

