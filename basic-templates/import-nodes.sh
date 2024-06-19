#!/bin/bash

source ~/stackrc
openstack overcloud node import ~/basic-templates/nodes-controller0.json
openstack overcloud node import ~/basic-templates/nodes-compute0.json
openstack overcloud node import ~/basic-templates/nodes-ceph0.json
