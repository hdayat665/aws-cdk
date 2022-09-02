FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
ADD /docker/webserver/nginx/conf.d/* /etc/nginx/conf.d/
COPY public /var/www/public
