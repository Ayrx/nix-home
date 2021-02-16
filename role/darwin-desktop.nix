{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.file.".Brewfile".source = ../config/Brewfile;
}
