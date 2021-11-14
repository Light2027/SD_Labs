FROM debian:jessie

## Run using: docker build --no-cache .

# Define Arguments
ARG MYSQL_ROOT_PASSWORD=admin
ARG MYSQL_DATABASE=test
ARG MYSQL_USER=admin
ARG MYSQL_PASSWORD=admin

# Mandatory Update
RUN apt update

# Install MySQL Server
RUN echo "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}" | debconf-set-selections
RUN apt -y install mysql-server

# Create database and configure user
RUN mysql


EXPOSE 3306 33060

# CMD ["mysqld"]