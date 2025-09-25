#!/bin/bash

# Script para instalar Prometheus usando Helm en Kubernetes

set -e  # Detener el script si ocurre un error

echo "Agregando el repositorio de Prometheus..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo "Actualizando repositorios Helm..."
helm repo update

echo "Creando el espacio de nombres 'monitorizacion'..."
kubectl create namespace monitorizacion || echo "El namespace ya existe. Continuando..."

echo "Instalando Prometheus en el namespace 'monitorizacion'..."
helm install prometheus prometheus-community/prometheus --namespace monitorizacion

echo "Instalación completada."
