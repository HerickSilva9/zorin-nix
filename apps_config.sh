#!/bin/bash
set -e

# Verificar instalação do Nix e seafile

echo 'Iniciando instalação...' && echo ''

echo 'Update & Upgrade'
sudo apt update && sudo apt upgrade -y

cd /tmp

# Instalar Google Chrome
echo '' && echo 'Instalando Google Chrome'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Instalar VSCode
echo '' && echo 'Instalando Visual Studio Code'
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code


# Instalar virt-manager Gerenciador de máquinas virtuas
echo '' && echo 'Instalando Virt-Manager'
sudo apt install -y virt-manager

# Instalar xfreerdp
echo '' && echo 'Instalando xfreerdp'
sudo apt install -y freerdp2-x11

# Instalar docker e docker-compose
echo '' && echo 'Instalando Docker'
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# Instalar UV (python package manager)
echo '' && echo 'Instalando UV'
curl -LsSf https://astral.sh/uv/install.sh | sh

# Instalar Rust
echo '' && echo 'Instalando Rust'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Instalar utilitários
echo '' && echo 'Instalando utilitários de sistema'
sudo apt install -y gdebi-core git vim kitty bat

# echo '' && echo 'Instalando Mega'
# Instalar Mega para ubuntu 24.04
# wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megasync-xUbuntu_24.04_amd64.deb && sudo apt install -y "$PWD/megasync-xUbuntu_24.04_amd64.deb"
# rm megasync-xUbuntu_24.04_amd64.deb

# Instalar ajustes do GNOME
# echo '' && echo 'Instalando Ajustes do GNOME'
# sudo apt install -y gnome-tweaks

# echo '' && echo 'Instalando xorriso e mkisofs'
# sudo apt install -y xorriso mkisofs

# Remover alicativos
# echo '' && echo 'Removendo firefox'
# sudo apt purge -y firefox
# sudo snap remove firefox

echo '' && echo 'Remover pacotes não necessários'
sudo apt autoremove -y

cd $HOME

echo '' && echo 'Reinicie o computador para aplicar as mudanças!'

echo '' && echo 'Instalação finalizada.'
