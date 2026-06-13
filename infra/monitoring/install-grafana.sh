#!/bin/bash

# Source:
# https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/

set -e 

## Set up the Grafana Helm repository

# Add the grafana Helm repository
helm repo add grafana-community https://grafana-community.github.io/helm-charts

# Verify the repository was added
if helm repo list | grep -q "^grafana-community"; then
    echo "Grafana Repository exists"
else
    echo "Repository not found"
    exit 1
fi

# Update the repository to download the latest Grafana Helm charts:
helm repo update

## Deploy the Grafana Helm charts

# Create a namespace 
kubectl create namespace monitoring

# Search for the official grafana-community/grafana helm charts repository
if helm search repo grafana-community/grafana | grep -q "^grafana-community/grafana"; then
    echo "Grafana chart found" 
else
    echo "Grafana chart not found"
    exit 1
fi

# Deploy the Grafana Helm Chart inside your namespace.
helm install my-grafana grafana-community/grafana --namespace monitoring

# Verify the deployment status
helm list -n monitoring

# Check the overall status of all the objects in the namespace
kubectl get all -n monitoring
