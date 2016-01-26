# PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH $PATH "/usr/local/opt/go/libexec/bin"
set -x PATH $PATH "$HOME/go/bin"

# ENV
set -x EDITOR "/usr/local/bin/nvim"
set -x GOPATH "$HOME/workspaces/go"

# vim-devicons
set -x guifont="Droid Sans Mono for Powerline Nerd Font Complete"

# pyenv and pyenv-virtualenv
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

# perlbrew
. ~/perl5/perlbrew/etc/perlbrew.fish

# homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.fish"

