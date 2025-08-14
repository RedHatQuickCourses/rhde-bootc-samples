#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the short name of a bootc container image." 2>&1
  exit 1
fi

if [ -z "$2" ]; then
  echo "Please provide the name of a SSH key pair." 2>&1
  exit 2
fi

if [ ! -r "$2.pub" ]; then
  echo "Cannot open the '$2.pub' SSH key file." 2>&1
  exit 2
fi

IMAGE="$1"

cp inst.ks.orig inst.ks

SSH_PUB_KEY=$( cat $2.pub )
sed -i "s|REPLACE_WITH_SSH_PUB_KEY|$SSH_PUB_KEY|" inst.ks
sed -i "1,$ s|REPLACE_WITH_IMAGE_SHORT_NAME|$IMAGE|" inst.ks

virt-install \
  --name $IMAGE \
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

