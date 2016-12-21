#!/bin/bash

###############################
# LAUNCH SERVICE
###############################

CURRENT_DIR=$(PWD)

# build images 
cd mysql
docker build -t mysqlbuild .
cd ../rabbit
docker build -t rabbitbuild .
cd ../memcache 
docker build -t memcachebuild .
cd ../keystone
docker build -t keystonebuild .
cd ..

# launch mysql container. the '-h db' is needed as it is used in the my.cnf as the bind address
docker run --name db -v $CURRENT_DIR/mysql/storage/mysql:/var/lib/mysql -h db  -p 3306:3306 -d mysqlbuild

# launch rabbit container and exec the post containe script to add user openstack 
docker run --name rabbit -d -p 5672:5672 -p 15672:15672 -v $CURRENT_DIR/rabbit/data:/data/mnesia rabbitbuild
docker exec -it rabbit /bin/bash -c "/root/post_container_setup.sh"

# launch memcache and the '-h memcache' is needed for the config file listen address
docker run --name memcache -d -p 11211:11211 -h memcache memcachebuild 

# launch keystone and link to the db, memcache and rabbit
docker run --name keystone -d \
        --link db:db --link memcache:memcache --link rabbit:rabbit \
        -v $CURRENT_DIR/keystone/etc/*:/etc/keystone \
        -v $CURRENT_DIR/keystone/logs:/var/log/apache2 \
        --env-file $CURRENT_DIR/environment.cfg \
        -p 35357:35357 -p 5000:5000 \
        -h keystone \
        keystonebuild 
docker exec -it keystone /bin/bash -c "/root/post_container_setup.sh"

# grab IP addresss fro a container 
#KEYIP=$(docker inspect keystone | grep IPAddress  | cut -d '"' -f 4 | sed -e 1b -e '$!d')

# grab ptvsd for debugging
#https://pypi.python.org/packages/9d/6a/1908c764f7eaf543fcd22771b59d0af2d80a1eb779fa9c966cf25f0e8108/ptvsd-3.0.0rc1.zip
#pip install ptvsd - added to dockerfile

# display services 
docker ps


