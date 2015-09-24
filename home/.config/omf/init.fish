# PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH $PATH "/usr/local/opt/go/libexec/bin"
set -x PATH $PATH "$HOME/go/bin"
set -x GOPATH "$HOME/go"

# ENV
set -x EDITOR "/usr/local/bin/nvim"

# pyenv and pyenv-virtualenv
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

# homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
