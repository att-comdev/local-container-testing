FROM ubuntu:16.04
MAINTAINER andre.pollard@att.com

# set container like parameters
ENV DEBIAN_FRONTEND noninteractive
ENV container docker

# update and install dependency packages
RUN apt-get update -qq && \
    apt-get install -y git curl python-pip python-dev nano python-memcache \
    libmysqlclient-dev libffi-dev libssl-dev ntp python-pymysql software-properties-common iputils-ping

# prevent keystone from starting since we use apache now
RUN echo "manual" > /etc/init/keystone.override

# add python dependencies and clients
#RUN pip install --upgrade pip
RUN pip install python-openstackclient  
RUN pip install repoze.lru pbr mysql-python ptvsd

# install apache package
RUN apt-get install -y apache2 libapache2-mod-wsgi

# create keystone database paths 
RUN mkdir -p /var/lib/keystone
RUN mkdir -p /var/log/keystone
RUN mkdir -p /etc/keystone

# setup startup stuff for keystone, stole script from apt package manager
COPY ./scripts/keystone_init.sh /tmp/keystone_init.sh
RUN chmod +x /tmp/keystone_init.sh
RUN /bin/bash -c "/tmp/keystone_init.sh install"

# copy keystone configuration files to proper location
COPY ./code/keystone/etc/keystone.conf.sample /etc/keystone/keystone.conf
COPY ./code/keystone/etc/default_catalog.templates /etc/keystone/default_catalog.templates
COPY ./code/keystone/etc/keystone-paste.ini /etc/keystone/keystone-paste.ini 
COPY ./code/keystone/etc/logging.conf.sample /etc/keystone/logging.conf
COPY ./code/keystone/etc/policy.json /etc/keystone/policy.json
COPY ./code/keystone/etc/policy.v3cloudsample.json /etc/keystone/policy.v3cloudsample.json
COPY ./code/keystone/etc/sso_callback_template.html /etc/keystone/sso_callback_template.html

# add configuration to keystone.conf
RUN sed -i "s/#admin_token = <None>/admin_token = e4d3fdd60a90a5408e6e/g" /etc/keystone/keystone.conf
RUN sed -i "s|#connection = <None>|connection = mysql://keystone:keystone@$KEYSTONE_DBPASS/keystone|g" /etc/keystone/keystone.conf
RUN sed -i "s/#provider = fernet/provider = fernet/g" /etc/keystone/keystone.conf

# copy keystone source code into contianer
COPY ./code/keystone /var/lib/keystone
RUN chown -R keystone:keystone /var/lib/keystone

# enable keystone apache site
# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN sed -i '1s/^/ServerName keystone\n/' /etc/apache2/apache2.conf
COPY ./code/keystone/httpd/wsgi-keystone.conf /etc/apache2/sites-available/wsgi-keystone.conf 
RUN ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled

# add in script to setup fernet tokens and initalize openstack default admin and service
COPY ./scripts/post_container_setup.sh /root/post_container_setup.sh
RUN chmod +x /root/post_container_setup.sh

# set working directory
RUN cd /var/lib/keystone
WORKDIR /var/lib/keystone
RUN rm -f /var/lib/keystone/keystone.db

# install keystone from source in /var/lib/keystone
RUN pip install . 

# expose openstack ports, 3001 is for debugging
EXPOSE 5000 35357 3001

# launch apache2
CMD /usr/sbin/apache2ctl -D FOREGROUND 







