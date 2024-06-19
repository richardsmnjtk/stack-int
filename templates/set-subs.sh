#!/bin/bash

#for i in {42..44}
#do
#  echo -e "\n=================================================="
#  echo "<==== Doing Check Subscription in Controller-$i ====>"
#  ssh heat-admin@10.2.3$i sudo subscription-manager list --consumed
#  echo "<==== Attach Repository OpenStack and RHEL TUS using Pool ID ====>"
#  ssh heat-admin@10.2.3.$i sudo subscription-manager register --username 'viky.hermana@i-3.co.id' --password 'Stupa2021'
#  ssh heat-admin@10.2.3.$i sudo subscription-manager attach --pool=2c948b68859c15590185c44563f57cc9
#  ssh heat-admin@10.2.3.$i sudo subscription-manager release
#  ssh heat-admin@10.2.3.$i sudo subscription-manager release --set=9.2
#  ssh heat-admin@10.2.3.$i sudo subscription-manager repos --disable=* --enable=rhel-9-for-x86_64-baseos-eus-rpms --enable=rhel-9-for-x86_64-appstream-eus-rpms --enable=rhel-9-for-x86_64-highavailability-eus-rpms --enable=openstack-17.1-for-rhel-9-x86_64-rpms --enable=fast-datapath-for-rhel-9-x86_64-rpms
#  ssh heat-admin@10.2.3.$i sudo dnf repolist
#  echo -e "==================================\n\n"
#done

echo -e "\n=================================================="
echo "<==== Doing Check Subscription in Compute ====>"
ssh heat-admin@10.2.3.45 sudo subscription-manager list --consumed
echo "<==== Attach Repository OpenStack and RHEL TUS using Pool ID ====>"
ssh heat-admin@10.2.3.45 sudo subscription-manager register --username 'viky.hermana@i-3.co.id' --password 'Stupa2021'
ssh heat-admin@10.2.3.45 sudo subscription-manager attach --pool=2c948b68859c15590185c44563f57cc9
ssh heat-admin@10.2.3.45 sudo subscription-manager release
ssh heat-admin@10.2.3.45 sudo subscription-manager release --set=9.2
ssh heat-admin@10.2.3.45 sudo subscription-manager repos --disable=* --enable=rhel-9-for-x86_64-baseos-eus-rpms --enable=rhel-9-for-x86_64-appstream-eus-rpms --enable=rhel-9-for-x86_64-highavailability-eus-rpms --enable=openstack-17.1-for-rhel-9-x86_64-rpms --enable=fast-datapath-for-rhel-9-x86_64-rpms
ssh heat-admin@10.2.3.45 sudo dnf repolist
echo -e "==================================\n\n"

echo -e "\n=================================================="
echo "<==== Doing Check Subscription in Ceph ====>"
ssh heat-admin@10.2.3.48 sudo subscription-manager list --consumed
echo "<==== Attach Repository OpenStack and RHEL TUS using Pool ID ====>"
ssh heat-admin@10.2.3.48 sudo subscription-manager register --username 'viky.hermana@i-3.co.id' --password 'Stupa2021'
ssh heat-admin@10.2.3.48 sudo subscription-manager attach --pool=2c948b68859c15590185c44563f57cc9
ssh heat-admin@10.2.3.48 sudo subscription-manager release
ssh heat-admin@10.2.3.48 sudo subscription-manager release --set=9.2
ssh heat-admin@10.2.3.48 sudo subscription-manager repos --disable=* --enable=rhel-9-for-x86_64-baseos-eus-rpms --enable=rhel-9-for-x86_64-appstream-eus-rpms --enable=rhel-9-for-x86_64-highavailability-eus-rpms --enable=openstack-17.1-for-rhel-9-x86_64-rpms --enable=fast-datapath-for-rhel-9-x86_64-rpms
ssh heat-admin@10.2.3.48 sudo dnf repolist
echo -e "==================================\n\n"
