Table of Contents
-------------------

 * [Installation](#installation)
 * [Quick Start](#quick-start)
 * [Linked to other container](#linked-to-other-container) 
 * [Logging](#logging)
 * [Out of the box](#out-of-the-box)

Installation
-------------------

 * [Install Docker](https://docs.docker.com/installation/) or [askubuntu](http://askubuntu.com/a/473720)
 * Pull the latest version of the image.
 
```bash
docker pull romeoz/docker-nginx
```

or development version (1.9.*):

```bash
docker pull romeoz/docker-nginx:1.9
```

Alternately you can build the image yourself.

```bash
git clone https://github.com/romeoz/docker-nginx.git
cd docker-nginx
docker build -t="$USER/docker-nginx" .
```

Quick Start
-------------------

Run the application image:

```bash
docker run --name app -d -p 8080:80 romeoz/docker-nginx
```

The simplest way to login to the app container is to use the `docker exec` command to attach a new process to the running container.

```bash
docker exec -it app bash
```

Linked to other container
-------------------

Create bridge networking:

```bash
docker network create app_net
```

>A new API available since Docker >1.9 

As an example, will link with PHP. 

```bash
docker run --name app -d \
    --net app_net
    -v /host/to/app:/var/www/app \
    romeoz/docker-phpfrpm
```

Contains `sites-enabled/app.conf`:

```
upstream backend {
    server app:9000;
}

server {
    listen   80 default_server;
    #listen [::]:80 ipv6only=on;

    root /var/www/app/;
    server_name app;
    index index.php;
    charset utf8;
  
    location /
    {
        rewrite ^ /index.php last;
    }

    location /index.php
    {
        include fastcgi.conf;
        fastcgi_pass backend;
    }
}
```

Run the nginx image:

```bash
docker run --name nginx -d \
    -v /host/to/sites-enabled:/etc/nginx/sites-enabled \
    --net app_net -p 8080:80 \ 
    romeoz/docker-nginx
```

Logging
-------------------

All the logs are forwarded to stdout and sterr. You have use the command `docker logs`.

```bash
docker nginx app
```

####Split the logs

You can then simply split the stdout & stderr of the container by piping the separate streams and send them to files:

```bash
docker logs nginx > stdout.log 2>stderr.log
cat stdout.log
cat stderr.log
```

or split stdout and error to host stdout:

```bash
docker logs nginx > -
docker logs nginx 2> -
```

####Rotate logs

Create the file `/etc/logrotate.d/docker-containers` with the following text inside:

```
/var/lib/docker/containers/*/*.log {
    rotate 31
    daily
    nocompress
    missingok
    notifempty
    copytruncate
}
```
> Optionally, you can replace `nocompress` to `compress` and change the number of days.

Out of the box
-------------------
 * Ubuntu 14.04.3 (LTS)
 * Nginx 1.8/1.9/1.10

License
-------------------

Nginx container image is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)