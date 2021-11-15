FROM debian:jessie

# Define Arguments
ENV WORDPRESS_DB_HOST=3306
ENV WORDPRESS_DB_USER=wordpress
ENV WORDPRESS_DB_PASSWORD=wordpress
ENV WORDPRESS_DB_NAME=wordpress

# Mandatory Update
RUN apt update

# Install and configure Apache2
RUN apt install -y apache2
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && service apache2 restart

# Install PHP
RUN apt install -y php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Set the working directory + volume
WORKDIR /var/www/html
VOLUME /var/www/html

# Install Wordpress
RUN apt install -y wget unzip
RUN wget http://wordpress.org/latest.zip && \
    unzip -q latest.zip -d . && \
    cd wordpress && \
    cp -a * .. && \
    cd .. && \
    rm -r latest.zip && \
    rm -r wordpress && \
    rm index.html && \
    chown www-data:www-data -R /var/www/html/

EXPOSE 80

CMD . /etc/apache2/envvars && apache2 && tail -f /dev/null