FROM ubuntu:16.04
MAINTAINER Andre.Pollard@att.com

RUN groupadd -r mysql && useradd -r -g mysql mysql
# usage USER mysql

# update and install mariadb
RUN apt-get update -qq && \
    apt-get install -y mariadb-server ntp 

# copy standard mysql config for mariadb
COPY ./config/my.cnf /etc/mysql/my.cnf

# mysql port exposed
EXPOSE 3306

# launch mysql
CMD ["mysqld_safe"]




