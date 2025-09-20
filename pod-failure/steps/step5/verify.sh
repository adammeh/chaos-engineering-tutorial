#!/bin/bash
echo "Checking Kubernetes cluster status..."
kubectl cluster-info
kubectl get nodes
echo "Environment preparation completed!"