#!/bin/bash
source ~/stackrc

openstack overcloud delete overcloud
openstack baremetal node delete $(openstack baremetal node list -f value -c UUID)
if [[ $(grep -oP " [0-9]+" /etc/rhosp-release) -ge 16 ]]; then
  echo "OSP16+ deleting overcloud and containers";
  openstack overcloud delete overcloud -y
  sudo podman rm -f $(sudo podman ps -aq)
  sudo podman rmi $(sudo podman images -q)
fi
rm /home/stack/undercloud-passwords.conf
systemctl list-unit-files | grep openstack | awk '{print $1}' | xargs -I {} sudo systemctl stop {}
systemctl list-unit-files | grep neutron | awk '{print $1}' | xargs -I {} sudo systemctl stop {}
sudo systemctl stop docker
sudo systemctl stop podman
sudo systemctl stop keepalived
sudo rm -rf /var/lib/mysql /var/lib/rabbitmq /etc/keystone /opt/stack/.undercloud-setup /root/stackrc /home/stack/stackrc  /var/opt/undercloud-stack /var/lib/ironic-discoverd/discoverd.sqlite /var/lib/ironic-inspector/inspector.sqlite  /home/stack/.instack /root/tripleo-undercloud-passwords /var/lib/registry /etc/pki/ca-trust/source/anchors/cm-local-ca.pem /httpboot/ /tftpboot/ /srv/* /var/lib/docker /etc/os-net-config/config.json
dirs="ceilometer heat glance horizon ironic ironic-discoverd keystone neutron nova swift haproxy"; for dir in $dirs; do sudo rm -rf /etc/$dir ; sudo rm -rf /var/log/$dir ;  sudo rm -rf /var/lib/$dir; done
sudo yum remove -y rabbitmq-server mariadb haproxy openvswitch keepalived $(rpm -qa | grep openstack) python-tripleoclient docker os-collect-config os-net-config
sudo rm -rf /etc/httpd/conf.d/10*
sudo rm -rf /etc/httpd/conf.d/25*
sudo rm -rf /etc/httpd/conf.d/openstack-tripleo-ui.conf.rpmsave
sudo sed -i '/:3000/d ; /:35357/d ; /:5000/d ; /:8042/d ; /:8774/d ; /:8777/d' /etc/httpd/conf/ports.conf
sudo rm -rf /etc/pki/tls/certs/undercloud*
sudo rm -rf /etc/pki/tls/private/undercloud*
sudo rm -rf /etc/pki/ca-trust/source/anchors/*local*
sudo rm -rf /etc/sysconfig/network-scripts/ifcfg-br-ctlplane
sudo mv  /etc/os-net-config/config.json  /etc/os-net-config/config.json.orig
sudo sed -i '/ovs/d ; /OVS/d'  /etc/sysconfig/network-scripts/ifcfg-eth1
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!! remove all interface configuration which is related to openvswitch from /etc/sysconfig/network-scripts, e.g. ifcfg-br_int, ifcfg-ovs_system, ifcfg-brctlplane, etc. roll back the configuration of the local interface!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!! Starting from RHOSP 12 /root/.my.cnf file should also be removed:
sudo rm /root/.my.cnf
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# With containerized undercloud, we also need to delete /var/lib/config-data/
sudo rm -rf /var/lib/config-data
sudo rm -rf /etc/cloud/


