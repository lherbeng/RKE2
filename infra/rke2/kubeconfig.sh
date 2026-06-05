#!/bin/bash
set -e

echo "Configuring default kubeconfig..."

mkdir -p ~/.kube
cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
chmod 600 ~/.kube/config

echo "Testing kubectl..."

kubectl get nodes