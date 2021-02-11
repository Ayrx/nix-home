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
    #sqlitebrowser
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
  programs.neovim.extraConfig = ''
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/rakr/vim-one.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent.git'
Plug 'junegunn/fzf'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'souffle-lang/souffle.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hashivim/vim-terraform'

call plug#end()

" Neovim Configurations
if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
set termguicolors
endif

" Auto reload NeoVim config
autocmd! BufWritePost init.vim,.vimrc source %

" General Configurations
syntax on
syntax sync fromstart
set ruler
set number
set backspace=2
set colorcolumn=80
set updatetime=100
set hidden
set autoread

filetype on
filetype plugin on
filetype indent on

" Colors
let airline_theme='one'
set background=dark
colorscheme one
highlight ColorColumn ctermbg=7

" Ignore files and directories
set wildignore+=*.pyc,*/build/*,*.o,*/node_modules/*,*/venv/*,*/target/*

" Configure gitgutter
let g:gitgutter_enabed = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" Strip trailing whitespaces on write
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Configure Coc
" Reenable this config once neovim 0.5.0 is released
" setlocal tagfunc=CocTagFunc

"Configure Rust
let g:rustfmt_command = "rustfmt +stable"
let g:rustfmt_autosave_if_config_present = 1

set tabstop=4 shiftwidth=4 expandtab
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype htmldjango setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
'';

  # Dotfiles
  home.file.".config/nvim/coc-settings.json".source = ../config/nvim/coc-settings.json;
  home.file.".tmux.conf".source = ../config/tmux/.tmux.conf;
  home.file.".config/fish/config.fish".source = ../config/fish/config.fish;
}
