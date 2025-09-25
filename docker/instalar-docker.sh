#!/bin/bash

# Este script debe ejecutarse como root

# Comprobación de usuario root
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root. Usa 'sudo o accede como root."
  exit 1
fi

# añadir clave GPG oficial de Docker:
apt-get update

# instalar el conjunto de certificados de autoridades (CA)
apt-get install -y ca-certificates curl

# configuración y descarga de las claves GPG
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Añadir el repositorio a orígenes apt:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

# descarga e instalación
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# habilitar los servicios para que arranquen al inicio
systemctl enable docker.service
systemctl enable containerd.service



