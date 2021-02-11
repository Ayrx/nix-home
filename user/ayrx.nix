{ config, lib, pkgs, ... }:

{
  # Packages to install
  home.packages = with pkgs; [
    # Core Tools
    ripgrep
    tokei
    curl
    wget
    fish
    tmux
    gnupg

    # Dev Tools
    openssl
    gdb
    git
    llvm
    sqlite
    sqlitebrowser
    cmake
    libffi

    # Security
    jadx
    jd-gui

    # Archive Tools
    p7zip
    xz
    zip

    # Language-specific Tools
    rustup
    nodejs

    # Others
    cloudflared
    terraform
    packer

    # Trivia
    fortune
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

  # Neovim
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.vimdiffAlias = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.withPython = true;
  programs.neovim.withPython3 = true;
  programs.neovim.extraPython3Packages = (ps: with ps; [
    pylint
  ]);

  # Dotfiles
  home.file.".config/nvim/init.vim".source = ../config/nvim/init.vim;
  home.file.".config/nvim/coc-settings.json".source = ../config/nvim/coc-settings.json;
  home.file.".tmux.conf".source = ../config/tmux/.tmux.conf;
  home.file.".config/fish/config.fish".source = ../config/fish/config.fish;
}
