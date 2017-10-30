#!/bin/bash

cd ../spark_compose
docker-compose up -d

docker exec -ti `docker ps | grep "spark-master" | awk '{print $1}'` bash -c "sudo chown hadoop:hadoop  /home/hadoop/spark_datas;sudo chown hadoop:hadoop  /home/hadoop/hadoop_datas;"

cd ../autoscripts
./initial_spark_all.sh

./start_all_in_order.sh

docker exec -ti `docker ps | grep "spark-master" | awk '{print $1}'` bash -c "mkdir -p /home/hadoop/spark_datas/spark_events"

docker exec -it spark-master bash