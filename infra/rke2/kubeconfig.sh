#!/bin/bash
set -e

echo "Waiting for RKE2..."
sleep 30

KCFG="$HOME/kubeconfig.yaml"

sudo cp /etc/rancher/rke2/rke2.yaml "$KCFG"
sudo chown $(id -u):$(id -g) "$KCFG"

echo "Using kubeconfig: $KCFG"

KUBECONFIG="$KCFG" kubectl get nodes -o wide