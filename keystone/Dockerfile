FROM ubuntu:16.04
MAINTAINER andre.pollard@att.com

# set container like parameters
ENV DEBIAN_FRONTEND noninteractive
ENV container docker

# update and install dependency packages
RUN apt-get update -qq && \
    apt-get install -y git curl python-pip python-dev keystone \
    libmysqlclient-dev libffi-dev libssl-dev ntp python-pymysql software-properties-common

#RUN add-apt-repository cloud-archive:mitaka
RUN echo "manual" > /etc/init/keystone.override

# add python dependencies and clients
RUN pip install --upgrade pip
RUN pip install python-glanceclient python-keystoneclient python-openstackclient  
RUN pip install repoze.lru pbr mysql-python
#RUN pip install oslo.log oslo.cache olso.messaging

# install apache package
RUN apt-get install -y apache2 libapache2-mod-wsgi


#RUN mkdir -p /var/lib/keystone
#RUN mkdir -p /var/log/keystone
#RUN mkdir -p /etc/keystone


# copy local keystone source to container
# developer most likely got from 
# git clone https://git.openstack.org/openstack/keystone.git
# and source is now on his local development machine in directory called keystone

# copy keystone configuration files to proper location
COPY ./etc/* /etc/keystone/
COPY ./keystone /var/lib/keystone

# enable keystone apache site
# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
COPY ./config/wsgi-keystone.conf /etc/apache2/sites-available/wsgi-keystone.conf 
RUN ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled

# add in script to setup fernet tokens to run after container is up
COPY ./scripts/post_container_setup.sh /root/post_container_setup.sh
RUN chmod +x /root/post_container_setup.sh

# setup startup stuff for keystone, stole script from apt package manager
COPY ./scripts/keystone_init.sh /root/keystone_init.sh
RUN chmod +x /root/keystone_init.sh
RUN /bin/bash -c "/root/keystone_init.sh install"

# set working directory
RUN cd /var/lib/keystone
WORKDIR /var/lib/keystone
RUN rm -f /var/lib/keystone/keystone.db

# install keystone 
RUN pip install . 

# expose openstack ports
EXPOSE 5000 35357

# launch apache2
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



