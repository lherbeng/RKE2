#!/bin/bash

set -e

# Add Grafana Helm repository
helm repo add grafana-community https://grafana-community.github.io/helm-charts || true

# Update Helm repositories
helm repo update

# Create namespace if not exists
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Install or upgrade Grafana
helm upgrade --install my-grafana grafana-community/grafana -n monitoring

# Show installed resources
helm list -n monitoring
kubectl get all -n monitoring