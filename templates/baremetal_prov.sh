#!/bin/bash

source ~/stackrc

openstack overcloud network provision --yes \
~/templates/00_overcloud_deployment_data/network_data.yaml \
--output ~/templates/02_overcloud_deployment/overcloud_deployed_networks.yaml

sleep 2
openstack overcloud network vip provision --yes \
--stack overcloud \
~/templates/00_overcloud_deployment_data/vip_data.yaml \
--output ~/templates/02_overcloud_deployment/overcloud_deployed_vips.yaml

sleep 2
openstack overcloud node provision --yes \
--stack overcloud \
--network-config \
~/templates/01_overcloud_deployment_pre/baremetal-deployment.yaml --debug \
--output ~/templates/02_overcloud_deployment/overcloud_deployed_nodes.yaml
