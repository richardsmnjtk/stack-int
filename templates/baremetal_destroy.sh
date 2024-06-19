#!/bin/bash

openstack overcloud node unprovision --yes \
--stack overcloud \
--all --network-ports \
~/templates/01_overcloud_deployment_pre/baremetal-deployment.yaml

sleep 2
openstack overcloud delete --yes \
-b ~/templates/01_overcloud_deployment_pre/baremetal-deployment.yaml \
--networks-file ~/templates/00_overcloud_deployment_data/network_data.yaml \
overcloud
