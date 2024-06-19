#!/bin/bash

source ~/stackrc
openstack overcloud node import /home/stack/instackenv.yaml

#for i in $(openstack baremetal node list -c UUID -c Name -f value | grep -i ceph | awk {'print $1'}) ; do openstack baremetal node set --property root_device='{"name":"/dev/vda"}'  $i ; done 
for i in $(openstack baremetal node list -c Name -f value | cut -d "-" -f2) ; do openstack baremetal node set --property capabilities=boot_option:local,node:$i-0,cpu_vt:true,cpu_aes:true,cpu_hugepages:true,cpu_hugepages_1g:true new-$i-0 ; done 
openstack baremetal node list -c UUID -f value | xargs -I {} openstack baremetal node show {} -c name -c properties -f json

openstack baremetal node list
metalsmith list
openstack baremetal allocation list

openstack overcloud node introspect --all-manageable --provide 
