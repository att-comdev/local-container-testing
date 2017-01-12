#!/bin/bash
###############################
# CLEAN UP IF EXIST
###############################
# stop sontainers
docker stop keystone
docker stop memcache
docker stop rabbit
docker stop db
#docker stop registry

# remove containers
docker rm keystone
docker rm memcache
docker rm rabbit
docker rm db
#docker rm registry

# remove image
# docker rmi keystonebuild
 #docker rmi mysqlbuild
# docker rmi rabbitbuild
# docker rmi memcachebuild

###############################
# END CLEANUP
###############################