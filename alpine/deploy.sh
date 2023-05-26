#!/bin/bash

# EXECUTANDO DEPLOYMENT FORÇANDO USO DO KUBECONFIG.
kubectl apply -f deployment.yaml --kubeconfig=$config