#!/bin/bash

podman run \
--rm --privileged \
--pid=host \
-v /:/target \
-v /dev:/dev \
-v /var/lib/containers:/var/lib/containers \
-v /home/student/edge-key.pub:/bootc_authorized_ssh_keys/root \
--security-opt label=type:unconfined_t \
registry.lab.example.com:5000/httpd-system:v1.0-1234 \
bootc install to-filesystem --skip-fetch-check --acknowledge-destructive --replace alongside \
--root-ssh-authorized-keys /bootc_authorized_ssh_keys/root \
--karg ip=172.25.250.11::172.25.250.0:255.255.255.0:bootc:ens3:off:172.25.250.220 \
/target

