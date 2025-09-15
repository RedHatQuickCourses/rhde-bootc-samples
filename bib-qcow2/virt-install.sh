#!/bin/bash
set -xeuo pipefail

virt-install --name bootc-qcow2 \
--vcpus 2 --memory 4096 \
--disk httpd-system.qcow2,size=20 \
--import \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--os-variant rhel10.0 \
--graphics=none \
--cloud-init user-data=user-data

