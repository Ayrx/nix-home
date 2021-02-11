{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Install pacakges that work on Linux but breaks on macOS
  home.packages = with pkgs; [
    fish
    sqlitebrowser
  ];
}
