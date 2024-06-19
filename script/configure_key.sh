#!/bin/bash

sudo chown $USER: /root/.ssh/authorized_keys
sudo chown $USER: /root/.ssh/
sudo chown $USER: /root/
cat ~/cephadm-rsa.pub >> /root/.ssh/authorized_keys
sudo chown root: /root/.ssh/authorized_keys
sudo chown root: /root/.ssh/
sudo chown root: /root/
