#!/bin/bash
set -xeuo pipefail

virt-install --name bootc-iso \
--vcpus 2 --memory 4096 \
--disk size=20 \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--location httpd-system.iso,kernel=/images/pxeboot/vmlinuz,initrd=/images/pxeboot/initrd.img \
--os-variant rhel10.0 \
--graphics=none \
--extra-arg inst.ks=hd:LABEL=$LABEL:/osbuild.ks \
--extra-arg console=ttyS0 -v
