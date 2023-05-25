#!/bin/bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
chmod +x ./kubectl'
export KUBECONFIG=$config'
./kubectl apply -f deployment.yaml --kubeconfig=$config'