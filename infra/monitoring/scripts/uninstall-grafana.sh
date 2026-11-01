#!/bin/bash

set -e

## Uninstall the Grafana Helm release

helm uninstall my-grafana -n monitoring

## Delete all Grafana resources by removing the namespace

kubectl delete namespace monitoring

## Remove the Grafana Helm repository

helm repo remove grafana-community

echo "Grafana and all related resources have been removed successfully."