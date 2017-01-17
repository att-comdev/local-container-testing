#!/bin/bash

sleep 20

keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap \
    --bootstrap-password admin_password \
    --bootstrap-username admin \
    --bootstrap-project-name admin \
    --bootstrap-role-name admin \
    --bootstrap-service-name keystone \
    --bootstrap-region-id RegionOne \
    --bootstrap-admin-url http://keystone:35357\v3 \
    --bootstrap-public-url http://keystone:5000\v3 \
    --bootstrap-internal-url http://keystone:5000\v3

echo 'DONE BOOTSTRAP'


# use to test
openstack --os-auth-url http://keystone:35357/v3 \
  --os-project-domain-name default --os-user-domain-name default \
  --os-password admin_password \
  --os-project-name admin --os-username admin token issue

