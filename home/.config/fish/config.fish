# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman


# PATH   
set -U fish_user_paths
set -Up fish_user_paths /usr/local/sbin
set -Up fish_user_paths /usr/local/bin
set -Up fish_user_paths /opt/homebrew/sbin
set -Up fish_user_paths /opt/homebrew/bin
set -Up fish_user_paths ~/opt/bin
set -Up fish_user_paths ~/.local/bin
set -Up fish_user_paths ~/bin
set -Ua fish_user_paths ~/opt/google-cloud-sdk/bin
set -Ua fish_user_paths ~/.pub-cache/bin
set -Ua fish_user_paths ~/flutter/bin
set -Ua fish_user_paths ~/Library/Android/sdk/platform-tools


# ENV   
set -x LANG "ko_KR.UTF-8"
set -x EDITOR /usr/local/bin/nvim
set -x GO111MODULE "on"
# flutter
# https://github.com/flutter/flutter/issues/25112
set -gx NO_PROXY localhost,127.0.0.1


# eval    
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish
source ~/.config/fish/credential.fish
source ~/.homesick/repos/homeshick/homeshick.fish
navi widget fish | source
zoxide init fish | source
starship init fish | source


# asdf
source /usr/local/opt/asdf/libexec/asdf.fish
# source (brew --prefix asdf)/asdf.fish
# source /opt/homebrew/opt/asdf/libexec/asdf.fish
# source (/opt/homebrew/bin/brew --prefix asdf)/asdf.fish
direnv hook fish | source
## asdf-java
asdf current java 2>&1 > /dev/null
. ~/.asdf/plugins/java/set-java-home.fish


# alias
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat --paging=never"
alias cd="z"
alias rm="trash"
alias ps="procs"
alias du="dust"
alias top="ytop"
alias gcloud="env ASDF_PYTHON_VERSION=3.7.12 gcloud"
alias diff="delta"
