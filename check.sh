#!/bin/bash


echo "--- TF ver ---"
terraform version
echo -e "\n--- Docker ver ---"
docker version
echo -e "\n--- GC SDK ver ---"
gcloud version
echo -e "\n--- Kubectl ver ---"
kubectl version
