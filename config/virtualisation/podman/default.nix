{ pkgs, ... }:

{
  home.packages = with pkgs; [
    podman           # O runtime de containers
    podman-compose   # Compatibilidade com docker-compose (Python)
  ];

  # Comando para execução de um container:
  # sudo env "PATH=$PATH" podman-compose up -d

  # Foi necessário executar os seguintes comandos antes
     # (procurar no futuro um modo de fazer tudo de forma declarativa)
#   sudo mkdir -p /etc/containers
#   sudo tee /etc/containers/policy.json > /dev/null << 'EOF'
#   {
#     "default": [
#       {
#         "type": "insecureAcceptAnything"
#       }
#     ]
#   }
#   EOF
 

}

