#!/bin/bash

rabbitmqctl start_app
# need to wait until rabbit fully start berofe adding user and permissions
echo 'Waiting for RabbitMQ to Start'
sleep 15
rabbitmqctl add_user openstack RABBIT_PASS
rabbitmqctl set_permissions openstack ".*" ".*" ".*"


