#!/bin/bash

set -e

USERNAME="vncuser"
PASSWORD=""

echo "Actualizando repositorios..."
apt-get update

echo "Instalando paquetes..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    haproxy \
    nano \
    telnet \
    sudo

echo "Creando usuario..."

if ! id "$USERNAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
    usermod -aG sudo $USERNAME
fi

echo "Activando haproxy..."
systemctl enable haproxy || true
systemctl start haproxy || true

echo "Post-instalación completada"
