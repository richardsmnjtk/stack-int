#!/bin/bash

cd /usr/share/openstack-tripleo-heat-templates
./tools/process-templates.py \
-o ~/tripleo-heat-templates-rendered \
-n /home/stack/basic-templates/31-network-data.yaml \
-r /home/stack/basic-templates/roles_data.yaml

sudo mv ~/tripleo-heat-templates-rendered /usr/share/tripleo-heat-templates-rendered
