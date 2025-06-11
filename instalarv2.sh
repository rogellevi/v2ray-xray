#!/bin/bash

# Script para instalar V2Ray con v2ray-util

set -e  # Salir al primer error
set -o pipefail

# Colores para salida
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m" # Sin color

log_info() { echo -e "${YELLOW}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Paso 1: Instalar python3-pip
log_info "Actualizando lista de paquetes..."
sudo apt update -y || { log_error "Error al actualizar paquetes"; exit 1; }

log_info "Instalando python3-pip..."
if sudo apt install -y python3-pip; then
    log_success "python3-pip instalado correctamente."
else
    log_error "Fallo al instalar python3-pip"
    exit 1
fi

# Paso 2: Instalar v2ray-util
log_info "Instalando v2ray-util con pip..."
if pip3 install v2ray-util; then
    log_success "v2ray-util instalado correctamente."
else
    log_error "Fallo al instalar v2ray-util"
    exit 1
fi

# Paso 3: Instalar V2Ray usando el script externo
log_info "Instalando V2Ray desde script remoto..."
if bash <(curl -sL https://multi.netlify.app/v2ray.sh); then
    log_success "V2Ray instalado correctamente."
else
    log_error "Fallo al ejecutar el script de instalación de V2Ray"
    exit 1
fi

log_success "Instalación completada exitosamente."
