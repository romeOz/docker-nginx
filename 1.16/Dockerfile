FROM ubuntu:bionic
MAINTAINER romeOz <serggalka@gmail.com>

ENV OS_LOCALE="en_US.UTF-8" \
    DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
	LANGUAGE=en_US:en \
	LC_ALL=${OS_LOCALE}

RUN	\
	BUILD_DEPS='wget gnupg' \
	&& apt-get install --no-install-recommends -y $BUILD_DEPS \
	&& wget -O - http://nginx.org/keys/nginx_signing.key | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=noninteractive apt-key add - \
	&& echo "deb http://nginx.org/packages/ubuntu/ bionic nginx" | tee -a /etc/apt/sources.list \
	&& echo "deb-src http://nginx.org/packages/ubuntu/ bionic nginx" | tee -a /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y nginx \
	# Cleaning
	&& apt-get purge -y --auto-remove $BUILD_DEPS \
	&& apt-get autoremove -y && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./configs/nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]