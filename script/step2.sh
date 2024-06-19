#!/bin/bash

sudo dnf install -y wget vim tmux git ipmitool OpenIPMI
sudo dnf install -y python3-tripleoclient
openstack tripleo container image prepare default \
  --local-push-destination \
  --output-env-file ~/containers-prepare-parameter.yaml


echo "  ContainerImageRegistryLogin: false
  ContainerImageRegistryCredentials:
    registry.redhat.io:
      11480789|openstack-i3 : eyJhbGciOiJSUzUxMiJ9.eyJzdWIiOiJiYmIxY2QwYTQyZDk0ZWNjOGMxZWZlZDUxNTk4ZWFjOSJ9.WxuABWWpEXHB7Kf3C4Ww0JPkTrypPMFpfV0ott3nldahvPn12A7eDWb6f1PvBUjPNRA9rKU7VocEG8QwWARENHZJY42ZL1UBzIQ0dw8hjph5Klx1RtP5sitAKSzTFm8km-AguESW3CAmHJxETCBiyniMUeiTKxpdGjyBjrR3mlk3oqjuZ12IDsakMo6m-EbfsjqjFyT2X_wUNEJqIDMBwXOJ-EKVoLe6PX1AbfoOd1sRWz5RkWH0olAtKPL-_yi8dkJdpcNblf2PnVb9haXfOr4f8dGZOshE7Zrsg99-Yza3rCJQXv70JrJ0hjhJ4LSQzyjwSzV81ZSR_8F4qS52wRVhXfdlyG2XsIQmCqRv1FDcwYru9_5QwoWWBkgx3DTHkhIifxvKxWCFPIY_xYe1pmyDwlmL05q1lwAtuwYfgltVumCvyExiEmWAdaHjeAwRq_F5tcOS0MJNMF8Pp4s9jAjpUF5oBWe-POfWZy3_k82BACeP8-a8ucZ4BcF_g5zRRrz799QS0q8NGFgDw9WhUb4UyqSBdroRhD36WA3Q2NVGhv1jiOgNofWf7jytTjN6WSEPcorl-XRDLvntl3QvhzY05Fnf95-06bwMi6_ggK3CotkFrmlTpgZq4TirdH3TvCDADj1Hza3yKXVDSdwXsaxxlBqMPe_yLMl2ngqge-w " >> ~/containers-prepare-parameter.yaml

cat <<EOF> /home/stack/custom-undercloud-params.yaml
parameter_defaults:
  AdminPassword: 'openstack123'
  NeutronEnableIsolatedMetadata: 'True'
EOF

echo -e "[DEFAULT]
container_images_file = /home/stack/containers-prepare-parameter.yaml
custom_env_files = /home/stack/custom-undercloud-params.yaml
enable_telemetry = false
generate_service_certificate = true
#hieradata_override = /home/stack/hieradata.yaml
local_interface = enp1s0
local_ip = 10.2.3.11/24
overcloud_domain_name = overcloud.kinton.lab
undercloud_admin_host = 10.2.3.12
undercloud_public_host = 10.2.3.13
undercloud_debug = false
undercloud_update_packages = false
undercloud_ntp_servers = 10.8.60.9
#undercloud_ntp_servers = 0.id.pool.ntp.org,1.id.pool.ntp.org,2.id.pool.ntp.org,3.id.pool.ntp.org
#undercloud_service_certificate = /etc/pki/tls/certs/undercloud.pem

[ctlplane-subnet]
cidr = 10.2.3.0/24
dhcp_start = 10.2.3.101
dhcp_end = 10.2.3.120
gateway = 10.2.3.11
inspection_iprange = 10.2.3.20,10.2.3.50
masquerade = true" > ~/undercloud.conf

time openstack undercloud install
sleep 4
sudo podman images
sudo podman ps

