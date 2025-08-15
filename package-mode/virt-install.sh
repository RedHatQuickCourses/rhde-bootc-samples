#!/bin/bash
set -xeuo pipefail

virt-install \
--name rpm-test \
--vcpus 2 \
--ram 4096 \
--disk size=20 \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--location http://content.example.com/rhel10.0/x86_64/dvd/ \
--os-variant rhel10.0 \
--initrd-inject ./inst.ks \
--extra-args inst.ks=file:/inst.ks 

#--graphics none \
#--extra-arg console=ttyS0 \
