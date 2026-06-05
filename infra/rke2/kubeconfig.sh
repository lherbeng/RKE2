#!/bin/bash

set -e

echo "Waiting for RKE2..."
sleep 30

sudo cp /etc/rancher/rke2/rke2.yaml ~/kubeconfig.yaml

export KUBECONFIG=~/kubeconfig.yaml

kubectl get nodes -o wide