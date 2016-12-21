#!/bin/bash
keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
  --bootstrap-admin-url http://keystone:35357/v3/ \
  --bootstrap-internal-url http://keystone:35357/v3/ \
  --bootstrap-public-url http://keystone:5000/v3/ \
  --bootstrap-region-id RegionOne

#unset OS_USER_DOMAIN_NAME

# openstack project create --domain default \
#  --description "Service Project" service

#openstack project create --domain default \
 # --description "Demo Project" demo

#openstack user create --domain default \
#  --password DEMO_PASS demo
