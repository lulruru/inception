FROM debian:bullseye

RUN apt-get update -y
RUN apt install nginx -y
RUN apt-get install vim -y
RUN apt-get install curl -y
RUN apt-get install openssl -y
RUN mkdir -p /etc/nginx/ssl



RUN	openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rencarna.42.fr/UID=rencarna"

RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html 
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]