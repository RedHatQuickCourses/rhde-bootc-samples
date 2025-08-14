#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the short name of a libvirt domain (VM)." 2>&1
  exit 1
fi

UUID=$( virsh domuuid $1 2>/dev/null )
if [ -z "$UUID" ]; then
  echo "Cannot find a domain (VM) named '$1'." 2>&1
  exit 2
fi

virsh destroy $1
virsh undefine $1 --remove-all-storage
