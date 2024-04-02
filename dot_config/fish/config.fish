# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman


# Homebrew
switch (sysctl -n machdep.cpu.brand_string)
    case '*Apple*'
        eval (/opt/homebrew/bin/brew shellenv)
    case '*'
        eval (/usr/local/bin/brew shellenv)
end


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
set -Ua fish_user_paths ~/.shorebird/bin
set -Ua fish_user_paths ~/Library/Android/sdk/tools
set -Ua fish_user_paths ~/Library/Android/sdk/tools/bin
set -Ua fish_user_paths ~/Library/Android/sdk/platform-tools
set -Ua fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# ENV   
set -x LANG "ko_KR.UTF-8"
set -x EDITOR nvim
set -x GO111MODULE on
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True
# flutter
# https://github.com/flutter/flutter/issues/25112
set -gx NO_PROXY localhost,127.0.0.1
# https://stackoverflow.com/questions/54441093/how-to-increase-eslint-memory-to-avoid-javascript-heap-out-of-memory
set -x NODE_OPTIONS "--max-old-space-size=8096"
# https://stackoverflow.com/questions/71320584/flutter-build-ios-got-error-requested-but-did-not-find-extension-point-with-ide
# set -x SDKROOT (xcrun -sdk macosx --show-sdk-path)
set -x ANDROID_HOME ~/Library/Android/sdk


# eval    
test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish
source ~/.config/fish/credential.fish
navi widget fish | source
zoxide init fish | source
starship init fish | source
atuin init fish | source


# asdf
source (brew --prefix asdf)/libexec/asdf.fish
## asdf-direnv
# direnv hook fish | source
## asdf-java
source ~/.asdf/plugins/java/set-java-home.fish


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
alias diff="delta"
alias network="bandwhich"
alias gcloud="env ASDF_PYTHON_VERSION=3.10.2 gcloud"
