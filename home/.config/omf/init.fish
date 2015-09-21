# Virtualenv
set -x PIP_REQUIRE_VIRTUALENV true
set -x PIP_VIRTUALENV_BASE "$HOME/.virtualenvs"
set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"

# PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH $PATH "/usr/local/opt/go/libexec/bin"
set -x PATH $PATH "$HOME/go/bin"
set -x GOPATH "$HOME/go"
set -x EDITOR "/usr/local/bin/nvim"

source "$HOME/.homesick/repos/homeshick/homeshick.fish"
