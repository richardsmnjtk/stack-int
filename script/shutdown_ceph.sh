#!/bin/bash

ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph status
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set noout
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set norecover
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set norebalance
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set nobackfill
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set nodown
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph osd set pause
ssh -q heat-admin@10.2.3.42 sudo cephadm shell -- ceph status
