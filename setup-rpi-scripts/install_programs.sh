#!/bin/bash -ux
# Script aims to install programs that I deem useful to the pi

# Discard stdin. Needed when running from an one-liner which includes a newline
read -t 0.1 -n 10000 discard

# Quit on error
set -e

check_root() {
# Check if the user is root or not
if [[ $EUID -ne 0 ]]; then
    SUDO='sudo -E -H'
else
  SUDO=''
fi
}

install_dependencies_debian() {
  REQUIRED_PACKAGES=(
    sudo
    tmux
    vim
    git
    cmake
    mosh
  )

  check_root
  # Disable interactive apt functionality
  export DEBIAN_FRONTEND=noninteractive
  # Update apt database, update all packages and install Ansible + dependencies
  $SUDO apt update -y;
  yes | $SUDO apt-get -o Dpkg::Options::="--force-confold" -fuy dist-upgrade;
  yes | $SUDO apt-get -o Dpkg::Options::="--force-confold" -fuy install "${REQUIRED_PACKAGES[@]}"
  yes | $SUDO apt-get -o Dpkg::Options::="--force-confold" -fuy autoremove;
  export DEBIAN_FRONTEND=
}

install_dependencies_debian

export dir=$HOME/dotfiles
if [ -d "$dir" ];
then
  pushd $dir
  git pull
  popd
else
  git clone https://github.com/Oskar283/dotfiles $dir
fi

/bin/bash $dir/install # Install dotfiles
