## Nix no ZorinOS

### Instalação do Nix
Utilizar o comando abaixo para instalar sem interação. Verificar forma de fazer isso já como sudo para não precisar digitar senha
https://nix.dev/manual/nix/2.28/installation/installing-binary.html#multi-user-installation
```
bash <(curl -L https://nixos.org/nix/install) --daemon --yes
```

Possivelmente essa seja uma boa opção, necessário testar
```
curl -L https://nixos.org/nix/install -o /tmp/install-nix.sh
sudo bash /tmp/install-nix.sh --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh  # Ativa nix no mesmo shell de instalação
```

### Ativar Home-Manager

Docs Home Manager
https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes

Primeiro é necessário ativar os experimental commands do arquivo de configuração do nix em `/etc/nix/nix.conf`

Reiniciar daemon do nix após ativar experimental commands
```
sudo cp nix.conf /etc/nix/
sudo systemctl restart nix-daemon.service
```

Gerar configurações iniciais
```bash
nix run home-manager/$branch -- init             # Somente gera os arquivos de configuração
# Edit files in ~/.config/home-manager
nix run home-manager/$branch -- init --switch    # Gera arquivos de configuração e já faz a ativação
nix run home-manager/$branch -- switch           # Faz a ativação caso ela não tenha sido executada na geração dos arquivos iniciais
```

### 

home-manager switch --flake ~/hmconf

After the initial activation has completed successfully then building and activating your flake-based configuration is as simple as

```bash
home-manager switch
```

It is possible to override the default configuration directory, if you want. For example,
```bash
nix run home-manager/$branch -- init --switch ~/hmconf
# And after the initial activation.
home-manager switch --flake ~/hmconf
```


