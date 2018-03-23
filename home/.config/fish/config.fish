# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman

# ENV   
set -x LANG "ko_KR.UTF-8"
set -x EDITOR "/usr/local/bin/nvim"   
set -x GOPATH "$HOME/go"    
set -x GOROOT "/usr/local/opt/go/libexec"
set -x COMPOSER_HOME "$HOME/.composer"
set -x HOMEBREW_GITHUB_API_TOKEN "***REMOVED***"
set -x KUBECONFIG "/Users/dididi/.bluemix/plugins/container-service/clusters/mycluster/kube-config-mel01-mycluster.yml"
#set -x RBENV_ROOT "/usr/local/var/rbenv"
#set -x PYENV_ROOT "/usr/local/var/pyenv"

# PATH   
set -x PATH "$HOME/bin" $PATH
set -x PATH "$HOME/.local/bin" $PATH
set -x PATH "/usr/local/sbin" $PATH
set -x PATH $PATH "$HOME/.cabal/bin"
set -x PATH $PATH "$HOME/.cargo/bin" 
set -x PATH $PATH "$GOROOT/bin"
set -x PATH $PATH "$GOPATH/bin"
set -x PATH $PATH "$COMPOSER_HOME/vendor/bin"
set -x PATH $PATH "/usr/local/share/dotnet"
set -x PATH $PATH "$HOME/opt/google-cloud-sdk/bin"
set -x PATH $PATH "$HOME/.fastlane/bin"
    
# pyenv and pyenv-virtualenv    
status --is-interactive; and . (pyenv init -|psub)    
status --is-interactive; and . (pyenv virtualenv-init -|psub)   

# rbenv
status --is-interactive; and . (rbenv init -|psub)

# eval    
eval (direnv hook fish)
source "$HOME/perl5/perlbrew/etc/perlbrew.fish"
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source /usr/local/opt/asdf/asdf.fish

# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish ]; and . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish
