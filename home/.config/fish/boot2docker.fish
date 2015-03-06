# Docker Parallels
# https://vagrantcloud.com/parallels/boxes/boot2docker
set -x DOCKER_HOST_IP (vagrant ssh-config | sed -n "s/[ ]*HostName[ ]*//gp")
set -x DOCKER_HOST tcp://$DOCKER_HOST_IP:2375

