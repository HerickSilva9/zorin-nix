{ config, pkgs, ...}:

{

  home.packages = with pkgs; [
    git

    # Visual Studio Code
    vscode

    # Neovim
    neovim vim wl-clipboard # gcc

    # UV 
    uv

  ];

}
