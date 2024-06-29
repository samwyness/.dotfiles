#!/usr/bin/env zsh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="git,homebrew,nvim,wezterm,zsh"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

# Create Code subdirectories
echo "Creating dev playground..."
mkdir $HOME/dev/_playground

echo "Creating dev directory for personal projects..."
mkdir $HOME/dev/samwyness

# Run installation
STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install.sh
