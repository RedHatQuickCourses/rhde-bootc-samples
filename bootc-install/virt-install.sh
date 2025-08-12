#!/bin/bash
set -xeuo pipefail

virt-install \
--name bootc-test \
--vcpus 2 \
--ram 4096 \
--disk size=20 \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--location http://content.example.com/rhel10.0/x86_64/dvd/ \
--os-variant rhel10.0 \
--initrd-inject ./inst.ks \
--memorybacking source.type=memfd,access.mode=shared \
--filesystem /home/student/temp-bootc,host-var-srv,driver.type=virtiofs \
--graphics none \
--extra-arg console=ttyS0 \
--extra-args inst.ks=file:/inst.ks 
