#!/bin/bash

openstack overcloud ceph user enable

openstack overcloud ceph deploy --yes \
--stack overcloud \
--cluster ceph \
--config ~/templates/01_overcloud_deployment_pre/initial-ceph.conf \
--crush-hierarchy ~/templates/01_overcloud_deployment_pre/crush_hierarchy.yaml \
--roles-data ~/templates/00_overcloud_deployment_data/roles_data.yaml \
--network-data ~/templates/00_overcloud_deployment_data/network_data.yaml \
--container-image-prepare ~/containers-prepare-parameter.yaml \
--output ~/templates/02_overcloud_deployment/overcloud_deployed_ceph.yaml \
~/templates/02_overcloud_deployment/overcloud_deployed_nodes.yaml --debug
