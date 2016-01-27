#!/bin/bash

set -e

echo "-- Building Nginx 1.8"
docker build -t nginx-18 ../1.8/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-18; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v $(docker ps -aq); sleep 5

echo
echo "-- Testing upstream"
docker run --name app -d -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --link app:app nginx-18; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker rmi -f nginx-18



echo
echo
echo "-- Building Nginx 1.9"
docker build -t nginx-19 ../1.9/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-19; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v $(docker ps -aq); sleep 5

echo
echo "-- Testing upstream"
docker run --name app -d -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --link app:app nginx-19; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker rmi -f nginx-19

echo
echo "-- Done"