#!/bin/bash

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Paso 1: Instalar python3-pip si no está instalado
echo "Paso 1: Verificando python3-pip..."
if command_exists pip3; then
    echo "✔️ python3-pip ya está instalado."
else
    echo "➕ Instalando python3-pip..."
    sudo apt update
    sudo apt install -y python3-pip
fi

# Paso 2: Instalar v2ray-util si no está instalado
echo "Paso 2: Verificando v2ray-util..."
if pip3 list | grep -q v2ray-util; then
    echo "✔️ v2ray-util ya está instalado."
else
    echo "➕ Instalando v2ray-util..."
    pip3 install v2ray-util
fi

# Paso 3: Ejecutar v2ray (opcional)
echo "Paso 3: Ejecutando v2ray (opcional)..."
if command_exists v2ray; then
    v2ray
else
    echo "⚠️ v2ray no se encontró como comando. Se instalará en el paso siguiente."
fi

# Paso 4: Ejecutar script remoto de instalación si no está instalado v2ray
echo "Paso 4: Ejecutando script remoto de instalación..."
# Puedes usar uno de los dos scripts: v2ray.sh o xray.sh
read -p "¿Deseas usar v2ray.sh (1) o xray.sh (2)? [1/2]: " choice
if [ "$choice" == "2" ]; then
    source <(curl -sL https://multi.netlify.app/xray.sh)
else
    source <(curl -sL https://multi.netlify.app/v2ray.sh)
fi

# Paso 5: Ejecutar v2ray
echo "Paso 5: Ejecutando v2ray..."
if command_exists v2ray; then
    v2ray
else
    echo "❌ No se pudo encontrar el comando 'v2ray' después de la instalación."
fi
