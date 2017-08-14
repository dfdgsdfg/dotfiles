# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman

# ENV   
set -x LANG "ko_KR.UTF-8"
set -x EDITOR "/usr/local/bin/nvim"   
set -x GOPATH "$HOME/go"    
set -x GOROOT "/usr/local/opt/go/libexec"
set -x COMPOSER_HOME "$HOME/.composer"
#set -x RBENV_ROOT "/usr/local/var/rbenv"
#set -x PYENV_ROOT "/usr/local/var/pyenv"

# PATH   
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH "$HOME/.local/bin" $PATH
set -x PATH "$HOME/.cabal/bin" $PATH
set -x PATH $PATH "$GOROOT/bin"
set -x PATH $PATH "$GOPATH/bin"    
set -x PATH $PATH "$COMPOSER_HOME/vendor/bin"
set -x PATH $PATH "/usr/local/share/dotnet"
set -x PATH $PATH "$HOME/opt/google-cloud-sdk/bin"
    
# pyenv and pyenv-virtualenv    
status --is-interactive; and . (pyenv init -|psub)    
status --is-interactive; and . (pyenv virtualenv-init -|psub)   

# rbenv
status --is-interactive; and . (rbenv init -|psub)

# eval    
source "$HOME/perl5/perlbrew/etc/perlbrew.fish"
source "$HOME/.homesick/repos/homeshick/homeshick.fish"

# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

