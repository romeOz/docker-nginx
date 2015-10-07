#!/bin/bash

set -e

echo "-- Building Nginx stable"
docker build -t nginx-stable ../stable/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-stable; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5

echo
echo "-- Testing upstream"
docker run --name app -d -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --link app:app nginx-stable; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f nginx-stable



echo
echo
echo "-- Building Nginx dev"
docker build -t nginx-dev ../dev/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-dev; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5

echo
echo "-- Testing upstream"
docker run --name app -d -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --link app:app nginx-dev; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v $(sudo docker ps -aq); sleep 5
docker rmi -f nginx-dev

echo
echo "-- Done"