set -x EDITOR nvim

# Nix setup
set PATH ~/.nix-profile/bin $PATH
set -x NIX_PATH ~/.nix-defexpr/channels $NIX_PATH

# Rust setup
set PATH ~/.cargo/bin $PATH
set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src

# Others
set -x PYTHONDONTWRITEBYTECODE 1
set PATH ~/tools/bin $PATH
set PATH ~/tools/ansible_bin $PATH
set PATH ~/.nix-profile/bin $PATH

if test (uname) = "Darwin"
    set -x NIX_SSL_CERT_FILE /etc/ssl/cert.pem

    if test (arch) = "arm64"
        eval (/opt/homebrew/bin/brew shellenv)
    else
        eval (/usr/local/bin/brew shellenv)
    end
end

# Functions
function ara
    if count $argv > /dev/null
        7z a -t7Z $argv[1].7z $argv[1]
    else
        echo "Error: Supply file to archive"
    end
end

function fish_greeting
    fortune -a
end

# Aliases
abbr -a autochrome ~/.local/autochrome/chrome --remote-debugging-port=9222
