#!/bin/bash
set -xeuo pipefail

virt-install --name bootc-qcow2 \
--vcpus 2 --memory 4096 \
--disk httpd-bootc.qcow2,size=20 \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--import \
--os-variant rhel10.0 \
--graphics=none \
--cloud-init clouduser-ssh-key=edge-key.pub

# do --extra-arg has any effect?
#--extra-arg console=ttyS0 -v
