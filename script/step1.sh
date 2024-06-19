#!/bin/bash

hostnamectl set-hostname nah-director-17.awan.local
hostnamectl set-hostname --transient nah-director-17.awan.local
echo "127.0.0.1 nah-director-17.awan.local director" >> /etc/hosts

useradd stack
echo stack | passwd --stdin openstack
echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack
clear

#echo  -e "\033[42;5m Enter Your RHN Username \033[0m"
#read username 
#echo  -e "\033[42;5m Enter Your RHN Password \033[0m"
#read -s password 
#subscription-manager register  --username $username  --password $password --force 
#subscription-manager list --available --all --matches="Red Hat OpenStack" > /tmp/sub.txt
#pool=$(cat /tmp/sub.txt | egrep -i "Employee SKU|pool"| awk {'print $3'} | tail -1)
#echo $pool
#subscription-manager attach --pool="$pool"

subscription-manager register --username 'viky.pratama@i-3.co.id' --password 'Redhat12345!@#$%'
subscription-manager list --available --all --matches="Red Hat OpenStack"
subscription-manager attach --pool=2c948b68859c15590185c44563f47cc7
subscription-manager release --set=9.0
echo rhel-9-for-x86_64-baseos-eus-rpms > /tmp/repo-rhosp17.txt
echo rhel-9-for-x86_64-appstream-eus-rpms >> /tmp/repo-rhosp17.txt
echo rhel-9-for-x86_64-highavailability-eus-rpms >> /tmp/repo-rhosp17.txt
echo openstack-17-for-rhel-9-x86_64-rpms >> /tmp/repo-rhosp17.txt
echo fast-datapath-for-rhel-9-x86_64-rpms >> /tmp/repo-rhosp17.txt
echo rhceph-5-tools-for-rhel-9-x86_64-rpms >> /tmp/repo-rhosp17.txt
echo openstack-17-deployment-tools-for-rhel-9-x86_64-rpms >> /tmp/repo-rhosp17.txt
subscription-manager repos --disable=*
for i in $(cat /tmp/repo-rhosp17.txt) ; do subscription-manager repos --enable=$i ; done
dnf update -y
reboot
