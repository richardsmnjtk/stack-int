#!/bin/bash

username=tripleo-admin
ctrl0=10.2.3.42
ctrl1=10.2.3.43
ctrl2=10.2.3.44
ceph0=10.2.3.47

echo "" > ~/.ssh/known_hosts
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph mgr module enable cephadm
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph orch set backend cephadm 
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph orch ps
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph cephadm generate-key
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph cephadm get-pub-key
ssh -o "StrictHostKeyChecking no" $username@$ctrl0 sudo cephadm shell -- ceph cephadm get-pub-key > /tmp/cephadm-rsa.pub

for i in $ctrl0 $ctrl1 $ctrl2 $ceph0 $ceph1;
do ssh -o "StrictHostKeyChecking no" $username@$i sudo hostname
scp -o "StrictHostKeyChecking no" /tmp/cephadm-rsa.pub $username@$i:/home/$username/cephadm-rsa.pub 
scp -o "StrictHostKeyChecking no" /home/stack/script/configure_key.sh $username@$i:/home/$username/
ssh -o "StrictHostKeyChecking no" $username@$i sudo chmod +x /home/$username/configure_key.sh
ssh -o "StrictHostKeyChecking no" $username@$i bash /home/$username/configure_key.sh
ssh -o "StrictHostKeyChecking no" $username@$i sudo rm -rf /home/$username/{cephadm-rsa.pub,configure_key.sh}
echo ""
sleep 2
done
