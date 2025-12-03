{ config, pkgs, ...}:

{
  imports = [
    ./browser
    ./development
    ./virtualisation/podman
  ];
}
