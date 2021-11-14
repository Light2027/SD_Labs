FROM debian:jessie

# Define Arguments
ARG WORDPRESS_DB_HOST=3306
ARG WORDPRESS_DB_USER=wordpress
ARG WORDPRESS_DB_PASSWORD=wordpress
ARG WORDPRESS_DB_NAME=wordpress

# Mandatory Update
RUN apt update

# Install Apache2
RUN apt install -y apache2

# Install PHP
RUN apt install -y php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Install and configure Wordpress

EXPOSE 80

# CMD ["apache2"]