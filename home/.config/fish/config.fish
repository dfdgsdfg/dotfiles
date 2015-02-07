# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins brew

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Perl Brew
. ~/perl5/perlbrew/etc/perlbrew.fish

# rbenv
status --is-interactive;
. (rbenv init -|psub)

# Virtualenv
set -x PIP_REQUIRE_VIRTUALENV=true
set -x PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"

# PATH
set -x PATH "$HOME/bin" $PATH
set -x PATH $PATH "/usr/local/opt/go/libexec/bin"
set -x PATH $PATH "$HOME/go/bin"
set -x GOPATH "$HOME/go"
set -x ANDROID_HOME "/usr/local/opt/android-sdk"
set -x EDITOR "/usr/local/bin/vim"

# Boot2docker
set -x DOCKER_HOST "tcp://192.168.59.103:2376"
set -x DOCKER_CERT_PATH "/Users/ipx/.boot2docker/certs/boot2docker-vm"
set -x DOCKER_TLS_VERIFY 1

# Docker Parallels
# https://vagrantcloud.com/parallels/boxes/boot2docker
# set -x DOCKER_HOST_IP (vagrant ssh-config | sed -n "s/[ ]*HostName[ ]*//gp")
# set -x DOCKER_HOST tcp://$DOCKER_HOST_IP:2375

source "$HOME/.homesick/repos/homeshick/homeshick.fish"

