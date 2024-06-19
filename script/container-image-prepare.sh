#!/bin/bash

sudo openstack tripleo container image prepare -r ~/templates/00_overcloud_deployment_data/roles_data.yaml -e ~/containers-prepare-parameter.yaml --output-env-file undercloud-container-images.yaml
