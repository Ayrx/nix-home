{ config, lib, pkgs, ... }:

{
  # Packages to install
  home.packages = with pkgs; [
    fortune
    neovim
    cmake
    gcc
    gdb
    git
    openssl
    libffi
    wget
    p7zip
    xz
    zip
    fish
    tmux
    curl
    llvm
    gnupg
    sqlite
    sqlitebrowser
    rustup
  ];

  # Git Configurations
  programs.git.enable = true;
  programs.git.userEmail = "terrycwk1994@gmail.com";
  programs.git.userName = "Terry Chia";

  programs.git.aliases = {
    lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  };

  programs.git.ignores = [ ".DS_Store" "*.swp" ];

  programs.git.extraConfig = {
    core = { autocrlf = "input"; editor = "nvim"; };
    color = { ui = "auto"; };
  };

home.file.".config/nvim/init.vim".source = ../config/nvim/init.vim;
home.file.".config/nvim/coc-settings.json".source = ../config/nvim/coc-settings.json;
home.file.".tmux.conf".source = ../config/tmux/.tmux.conf;
home.file.".config/fish/config.fish".source = ../config/fish/config.fish;
}
