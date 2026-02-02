# fisher
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman

# Homebrew, mise
switch (sysctl -n machdep.cpu.brand_string)
    case '*Apple*'
        eval (/opt/homebrew/bin/brew shellenv)
        if test "$VSCODE_RESOLVING_ENVIRONMENT" = 1
            mise activate fish --shims | source
        else if status is-interactive
            mise activate fish | source
        else
            mise activate fish --shims | source
        end
    case '*'
        eval (/usr/local/bin/brew shellenv)
        if test "$VSCODE_RESOLVING_ENVIRONMENT" = 1
            mise activate fish --shims | source
        else if status is-interactive
            mise activate fish | source
        else
            mise activate fish --shims | source
        end
end

# https://mise.jdx.dev/ide-integration.html
if status is-interactive
else
    mise activate fish --shims | source
end

# https://rustup.rs/
source "$HOME/.cargo/env.fish"

# PATH
set -U fish_user_paths
set -Up fish_user_paths /usr/local/sbin
set -Up fish_user_paths /usr/local/bin
set -Up fish_user_paths /opt/homebrew/sbin
set -Up fish_user_paths /opt/homebrew/bin
set -Up fish_user_paths ~/opt/bin
set -Up fish_user_paths ~/opt/bin/depot_tools
set -Up fish_user_paths ~/.local/bin
set -Up fish_user_paths ~/bin
set -Up fish_user_paths ~/.pub-cache/bin
set -Ua fish_user_paths ~/Library/Android/sdk/tools
set -Ua fish_user_paths ~/Library/Android/sdk/tools/bin
set -Ua fish_user_paths ~/Library/Android/sdk/platform-tools
set -Ua fish_user_paths ~/.maestro/bin
set -Ua fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# Added by Antigravity
set -Ua fish_user_paths ~/.antigravity/antigravity/bin
# Lean theorem prover
set -Ua fish_user_paths ~/.elan/bin

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

# pnpm
set -gx PNPM_HOME /Users/dididi/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# https://ccache.dev/
# https://github.com/invertase/firestore-ios-sdk-frameworks/discussions/82
# https://dev.to/leehack/optimize-flutter-ios-build-using-ccache-2oi2
if command -v ccache >/dev/null 2>&1
    set -Up fish_user_paths /opt/homebrew/opt/ccache/libexec
    set -gx CCACHE_SLOPPINESS clang_index_store,file_stat_matches,include_file_ctime,include_file_mtime,ivfsoverlay,pch_defines,modules,system_headers,time_macros
    set -gx CCACHE_FILECLONE true
    set -gx CCACHE_DEPEND true
    set -gx CCACHE_INODECACHE true
end

# alias
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat --paging=never -p"
alias cd="z"
alias rm="trash"
alias ps="procs"
alias du="dust"
alias top="btm"
alias diff="delta"
alias network="bandwhich"
#alias gcloud="env MISE_PYTHON_VERSION=3.12.4 gcloud"
alias npm_legacy="command npm"
alias npm="pnpm"
alias http="xh"

# Added by Windsurf
fish_add_path /Users/dididi/.codeium/windsurf/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
