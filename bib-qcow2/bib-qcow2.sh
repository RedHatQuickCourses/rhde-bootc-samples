#!/bin/bash
set -xeuo pipefail

sudo podman run --rm -it --privileged --pull=newer \
    --security-opt label=type:unconfined_t \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    -v $(pwd)/config.toml:/config.toml \
    -v $(pwd)/output:/output \
    registry.lab.example.com:5000/rhel10/bootc-image-builder \
    --type qcow2 --local --config /config.toml \
    registry.lab.example.com:5000/httpd-bootc:v1.0
