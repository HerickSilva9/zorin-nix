#!/bin/bash

set -e

EXPECTED_DIR="$HOME/.config/home-manager"
CURRENT_DIR="$(pwd)"

if [ "$CURRENT_DIR" != "$EXPECTED_DIR" ]; then
    echo "Este script deve ser executado em: $EXPECTED_DIR"
    echo "Diretório atual: $CURRENT_DIR"
    exit 1
fi

# Atualiza lista de pacotes
sudo apt update

# Instalar Nix
echo '' && echo 'Instalando Nix...'
curl -L https://nixos.org/nix/install -o /tmp/install-nix.sh
sudo bash /tmp/install-nix.sh --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh  # Ativa nix no mesmo shell de instalação

# Copia o arquivo de configuração do nix com comandos de ativação dos comandos experimentais
echo '' && echo 'Ativando experimental-features...'
sudo cp etc /nix/nix.conf /etc/nix/
sudo systemctl restart nix-daemon.service # Reiniciar daemon do nix após ativar experimental commands

# Faz a ativação do home-manager no canal unstable caso ele esteja em ~/.config/home-manager/
echo '' && echo 'Ativando home-manager...'
nix run home-manager/master -- switch

# Após a primeira ativação é possível fazer o switch no próprio shell
# `home-manager switch` caso os arquivos estejam em ~/.config/home-manager; ou
# `home-manager switch --flake <flake-path>/
