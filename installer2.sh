#!/bin/bash

# Script para instalar o desinstalar V2Ray y v2ray-util

LOG_FILE="install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

set -e
set -o pipefail

# Colores para salida
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

log_info() { echo -e "${YELLOW}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

install_v2ray() {
    log_info "Actualizando lista de paquetes..."
    sudo apt update -y

    log_info "Instalando python3-pip..."
    sudo apt install -y python3-pip

    log_info "Instalando v2ray-util con pip..."
    pip3 install v2ray-util

    log_info "Instalando V2Ray desde script remoto..."
    bash <(curl -sL https://multi.netlify.app/v2ray.sh)

    log_success "Instalación completada exitosamente."
}

uninstall_v2ray() {
    log_info "Desinstalando v2ray-util..."
    pip3 uninstall -y v2ray-util || log_info "v2ray-util no estaba instalado."

    log_info "Desinstalando V2Ray (si está instalado)..."
    if command -v v2ray >/dev/null; then
        sudo systemctl stop v2ray || true
        sudo systemctl disable v2ray || true
        sudo rm -rf /usr/bin/v2ray /etc/v2ray /var/log/v2ray
        sudo rm -f /etc/systemd/system/v2ray.service
        log_success "V2Ray desinstalado."
    else
        log_info "V2Ray no estaba instalado."
    fi

    log_success "Desinstalación completada."
}

# MAIN
if [[ "$1" == "--uninstall" ]]; then
    uninstall_v2ray
else
    install_v2ray
fi
