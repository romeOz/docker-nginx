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
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-18; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
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
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-19; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-19


echo
echo
echo "-- Building Nginx 1.10"
docker build -t nginx-110 ../1.10/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-110; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-110; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-110


echo
echo
echo "-- Building Nginx 1.11"
docker build -t nginx-111 ../1.11/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-111; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-111; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-111


echo
echo
echo "-- Building Nginx 1.12"
docker build -t nginx-112 ../1.12/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-112; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-112; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'

echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-112


echo
echo
echo "-- Building Nginx 1.13"
docker build -t nginx-113 ../1.13/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-113; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-113; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'


echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-113


echo
echo
echo "-- Building Nginx 1.14"
docker build -t nginx-114 ../1.14/

echo
echo "-- Testing server is running"
docker run --name app -d -p 8080:80 nginx-114; sleep 5
curl -I 127.0.0.1:8080 2>/dev/null | grep -wc '200 OK'

echo
echo "-- Clear"
docker rm -f -v app; sleep 5

echo
echo "-- Testing upstream"
docker network create ngx_test
docker run --name app -d --net ngx_test -v $(pwd)/app:/var/www/app romeoz/docker-phpfpm; sleep 5
docker run --name nginx-test -d -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -p 8080:80 --net ngx_test nginx-114; sleep 5
curl 127.0.0.1:8080 2>/dev/null | grep -wc 'Hello world'

echo
echo "-- Clear"
docker rm -f -v app nginx-test; sleep 5
docker network rm ngx_test
docker rmi -f nginx-114

echo
echo "-- Done"