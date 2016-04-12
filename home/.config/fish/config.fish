# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# ENV   
set -x EDITOR "/usr/local/bin/nvim"   
set -x GOPATH "$HOME/go"    
set -x GOROOT "/usr/local/opt/go/libexec"

# PATH   
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/bin" $PATH   
set -x PATH $PATH "$GOROOT/bin"
set -x PATH $PATH "$GOPATH/bin"    
set -x PATH $PATH "$HOME/miniconda3/bin"    

# vim-devicons    
set -x guifont "Droid Sans Mono for Powerline Nerd Font Complete"   
    
# pyenv and pyenv-virtualenv    
status --is-interactive; and . (pyenv init -|psub)    
status --is-interactive; and . (pyenv virtualenv-init -|psub)   
    
# eval    
source "$HOME/perl5/perlbrew/etc/perlbrew.fish"
source "$HOME/.homesick/repos/homeshick/homeshick.fish"

