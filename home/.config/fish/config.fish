# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman



# PATH   
set -U fish_user_paths
set -Up fish_user_paths "/usr/local/sbin"
set -Up fish_user_paths "/usr/local/bin"
set -Up fish_user_paths "/opt/homebrew/sbin"
set -Up fish_user_paths "/opt/homebrew/bin"
set -Up fish_user_paths "$HOME/.local/bin"
set -Up fish_user_paths "$HOME/bin"
set -Up fish_user_paths "$HOME/.asdf/shims"
set -Ua fish_user_paths "$HOME/.cabal/bin"
set -Ua fish_user_paths "$HOME/.cargo/bin"
set -Ua fish_user_paths "$HOME/.pub-cache/bin"
set -Ua fish_user_paths "$HOME/flutter/bin"
set -Ua fish_user_paths "$GOROOT/bin"
set -Ua fish_user_paths "$GOPATH/bin"
set -Ua fish_user_paths "$GEM_HOME/bin"
set -Ua fish_user_paths "$COMPOSER_HOME/vendor/bin"
set -Ua fish_user_paths "/usr/local/share/dotnet"
set -Ua fish_user_paths "$HOME/opt/google-cloud-sdk/bin"
set -Ua fish_user_paths "$HOME/.fastlane/bin"     
set -Ua fish_user_paths "$HOME/Library/Android/sdk/platform-tools/"


# eval    
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source (brew --prefix asdf)/asdf.fish
# source (/opt/homebrew/bin/brew --prefix asdf)/asdf.fish
eval (direnv hook fish)
navi widget fish | source
zoxide init fish | source
source ~/.config/fish/credential.fish
## asdf-java
asdf current java 2>&1 > /dev/null
if test $status -eq 0
    set -x JAVA_HOME (asdf where java)
end


# ENV   
set -x LANG "ko_KR.UTF-8"
set -x EDITOR "/usr/local/bin/nvim"   
set -x GOPATH "$HOME/go"    
set -x GOROOT (asdf where golang)/go/
set -x COMPOSER_HOME "$HOME/.composer"
set -x GO111MODULE "on"
set -x GEM_HOME $HOME/.gem
set -x CLOUDSDK_PYTHON_SITEPACKAGES "1"
# flutter
# https://github.com/flutter/flutter/issues/25112
set -gx NO_PROXY localhost,127.0.0.1


# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# alias
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat='bat'
alias cd="z"
