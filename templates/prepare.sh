#!/bin/bash

source ~/stackrc
t1=$(date +'%s')
start_deploy=$(date)

openstack overcloud update prepare --templates \
-n ~/templates/00_overcloud_deployment_data/network_data.yaml \
-r ~/templates/00_overcloud_deployment_data/roles_data.yaml \
-e ~/containers-prepare-parameter.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/cephadm/cephadm.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/cinder-backup.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/disable-swift.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovn-ha.yaml \
-e ~/templates/overcloud/10-inject-trust-anchor.yaml \
-e ~/templates/overcloud/12-low-memory-usage.yaml \
-e ~/templates/overcloud/14-disable-telemetry.yaml \
-e ~/templates/overcloud/22-change_root_password-env.yaml \
-e ~/templates/overcloud/24-admin-password.yaml \
-e ~/templates/overcloud/26-barbican-config.yaml \
-e ~/templates/overcloud/28-enable-designate.yaml \
-e ~/templates/overcloud/61-octavia.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_storage_config.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_deployed_ceph.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_deployed_vips.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_deployed_networks.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_deployed_nodes.yaml \
-e ~/templates/02_overcloud_deployment/overcloud_customizations.yaml


#-e /usr/share/openstack-tripleo-heat-templates/environments/ssl/tls-endpoints-public-dns.yaml \
#-e ~/templates/overcloud/18-extraconfig.yaml \

#bash ~/templates/post_deploy.sh

t2=$(date +'%s')
finish_deploy=$(date)
t_delta=$(bc <<< "($t2 - $t1)")
t_delta_mins=$(bc <<< "($t_delta / 60)")
t_delta_hour=$(bc <<< "($t_delta_mins / 60)")
t_delta_min=$(bc <<< "$t_delta_mins - ($t_delta_hour * 60)")
t_delta_sec=$(bc <<< "$t_delta - ($t_delta_mins * 60)")

echo $'\n=======================================================' 
echo "|  Started deploy at: ${start_deploy} " 
echo "|  Finised deploy at: ${finish_deploy}"
echo "|  Total duration: $t_delta_hour hour(s), $t_delta_min min(s), $t_delta_sec sec(s) "
echo $'========================================================\n'

