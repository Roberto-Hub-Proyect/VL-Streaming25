

#!/bin/bash

# Este script debe ejecutarse como root

# Comprobación de usuario root
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root. Usa 'sudo ./instalar-minikube.sh' o accede como root."
  exit 1
fi

# Actualización de paquetes
apt-get update

# Instalación de curl y apt-transport-https
apt-get install -y curl apt-transport-https

# Descarga de la última versión de Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# Instalación de Minikube y eliminación del binario descargado
install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

