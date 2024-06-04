FROM debian:bullseye
RUN apt update -y
RUN apt upgrade -y
RUN apt-get -y install wget
RUN apt-get install -y php7.4\
	php-fpm\
	php-mysql\
	default-mysql-client\
	mariadb-client

RUN apt-get clean
#vider le cache
RUN rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /var/www/html

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz -P /var/www

RUN cd /var/www\
 	&& tar -xzf wordpress-6.2.2.tar.gz\
	&& rm wordpress-6.2.2.tar.gz\
	&& cp -r /var/www/wordpress/. /var/www/html/

	RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/*

RUN cd /var/www/html \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
	&& chmod +x wp-cli.phar\
	&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wordpressscript.sh /bin/wordpressscript.sh

RUN chmod 777 /bin/wordpressscript.sh

ENTRYPOINT ["bash", "/bin/wordpressscript.sh"]