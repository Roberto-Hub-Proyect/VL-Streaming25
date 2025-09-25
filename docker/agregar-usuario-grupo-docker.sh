#!/bin/bash

# Script para agregar el usuario actual al grupo docker y aplicar cambios inmediatamente y para futuras sesiones.
# Uso: sudo ./agregar_a_docker.sh

# Verificar que se ejecute como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecute este script como root o con sudo."
  exit 1
fi

# Detectar usuario que inició sesión (no root)
USUARIO=$(logname 2>/dev/null || echo $SUDO_USER)

if [ -z "$USUARIO" ]; then
  echo "No se pudo detectar el usuario que inició sesión."
  exit 1
fi

echo "Usuario detectado: $USUARIO"

# Crear grupo docker si no existe
if ! getent group docker >/dev/null; then
  echo "📦 Creando grupo docker..."
  groupadd docker
else
  echo "El grupo docker ya existe."
fi

# Agregar usuario al grupo docker
echo "Agregando usuario $USUARIO al grupo docker..."
usermod -aG docker "$USUARIO"

# Confirmar que se agregó correctamente
if id -nG "$USUARIO" | grep -qw docker; then
  echo "El usuario ya estaba en el grupo docker."
else
  echo "Usuario agregado al grupo docker."
fi

# Aplicar cambios de grupo para la sesión actual
echo "Aplicando cambios de grupo para $USUARIO..."
sudo -u "$USUARIO" newgrp docker <<EONG
echo "Cambios aplicados: ahora puedes usar Docker sin reiniciar sesión."
echo "En nuevas terminales y futuras sesiones, este cambio seguirá activo."
EONG

