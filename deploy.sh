#!/bin/bash

# DOWNLOAD DO KUBECTL
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'

# PERMISSÃO PARA O KUBECTL
chmod +x ./kubectl'

# EXPORTANDO KUBECONFIG USANDO VARIAVEL CRIADA NO JENKINSFILE
export KUBECONFIG=$config'

# EXECUTANDO DEPLOYMENT FORÇANDO USO DO KUBECONFIG.
./kubectl apply -f deployment.yaml --kubeconfig=$config'