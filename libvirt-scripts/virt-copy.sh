#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the short name of a bootc container image." 2>&1
  exit 1
fi

IMAGE="$1"

DIGEST=$( skopeo inspect --format '{{ .Digest }}'  containers-storage:localhost/$IMAGE )

if [ -z "$1" ]; then
  echo "Cannot find container image named 'localhost/$IMAGE'." 2>&1
  exit 1
fi

skopeo copy containers-storage:localhost/$IMAGE oci:/home/student/temp-bootc/oci:$IMAGE
