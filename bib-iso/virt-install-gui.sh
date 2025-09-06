#!/bin/bash
set -xeuo pipefail

virt-install \
--name bootc-iso \
--vcpus 2 \
--ram 4096 \
--disk size=20 \
--network passt,portForward0=8022:22,portForward1=8080:80 \
--cdrom httpd-bootc.iso \
--os-variant rhel10.0 
