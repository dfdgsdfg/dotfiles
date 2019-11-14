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
set -x NVM_DIR "$HOME/.nvm"
set -gx nvm_prefix "/usr/local/opt/nvm/"
set -x GO111MODULE "on"
# flutter
# https://github.com/flutter/flutter/issues/25112
set -gx NO_PROXY localhost,127.0.0.1
source ~/.config/fish/credential.fish


# PATH   
set -U fish_user_paths
set -Up fish_user_paths "$HOME/bin" 
set -Up fish_user_paths "$HOME/.local/bin" 
set -Up fish_user_paths "/usr/local/sbin" 
set -Ua fish_user_paths "$HOME/.cabal/bin"
set -Ua fish_user_paths "$HOME/.cargo/bin"
set -Ua fish_user_paths "$HOME/.pub-cache/bin"
set -Ua fish_user_paths "$HOME/flutter/bin"
set -Ua fish_user_paths "$GOROOT/bin"
set -Ua fish_user_paths "$GOPATH/bin"
set -Ua fish_user_paths "$COMPOSER_HOME/vendor/bin"
set -Ua fish_user_paths "/usr/local/share/dotnet"
set -Ua fish_user_paths "$HOME/.rbenv/bin"
set -Ua fish_user_paths "$HOME/.rbenv/shims"
set -Ua fish_user_paths "$HOME/opt/google-cloud-sdk/bin"
set -Ua fish_user_paths "$HOME/.fastlane/bin"     

# pyenv and pyenv-virtualenv    
status --is-interactive; and source (pyenv init -|psub)    
status --is-interactive; and source (pyenv virtualenv-init -|psub)   

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# eval    
source "$HOME/perl5/perlbrew/etc/perlbrew.fish"
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source /usr/local/opt/asdf/asdf.fish

# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish ]; and . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.fish

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/dididi/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/dididi/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/dididi/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/dididi/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dididi/bin/google-cloud-sdk/path.fish.inc' ]; . '/Users/dididi/bin/google-cloud-sdk/path.fish.inc'; end
