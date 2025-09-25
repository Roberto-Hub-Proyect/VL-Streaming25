#!/bin/bash

# Script para instalar docker-compose y python3-setuptools

# Verificar que se ejecute como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecute este script como root o con sudo."
  exit 1
fi

# Actualizar lista de paquetes
apt update

# Instalar docker-compose
apt install -y docker-compose

# Instalar python3-setuptools
apt install -y python3-setuptools

echo "Instalación completada."

