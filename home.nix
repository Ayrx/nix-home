{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "21.03";

  imports = [
    ./role/linux-desktop.nix
    ./user/ayrx.nix
  ];

  home.username = "ayrx";
  home.homeDirectory = "/home/ayrx";
}
