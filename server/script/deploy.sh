#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=dayday

cp $REPOSITORY/zip/build/libs/*.jar $REPOSITORY/
CURRENT_PID=$(pgrep -fl dayday | grep java | awk '{print $1}')


if [ -z "$CURRENT_PID" ]; then
  ehco "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

while [ $(netstat -tnl | grep 8080 | wc -l) != 0 ]
do
  echo "waiting for terminate"
  sleep 5
done


JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

chmod +x $JAR_NAME

chmod -R 775 org.*

nohup java -jar \
    -Dspring.profiles.active=prod \
    $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &