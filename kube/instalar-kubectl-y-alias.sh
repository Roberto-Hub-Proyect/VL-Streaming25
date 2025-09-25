#!/bin/bash
# Este script debe ejecutarse como root

# Comprobación de usuario root
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root. Usa 'sudo o accede como root."
  exit 1
fi

# Descarga de la version
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl

# Descarga checksum para validación del binario
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256

# Validacion del binario (debe obtenerse kubectl: OK)
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Instalacion kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Comprobacion versión kubectl
kubectl version --client

# Alias para facilitar uso del comando
alias kubectl="minikube kubectl --"

