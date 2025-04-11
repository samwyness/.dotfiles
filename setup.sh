#!/usr/bin/env zsh

LOG_VERBOSE=false
RUN_INSTALL=true
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Include the logger
source $SCRIPT_DIR/logger.sh

log_info "Setting up your Mac..."

# Run installation
chmod +x $SCRIPT_DIR/install.sh
$SCRIPT_DIR/install.sh

# Setup dotfile symlinks
STOW_ROOT_DIRS="git,zsh" # Directories symlinked into ~/
STOW_CONFIG_DIRS="homebrew,nvim,wezterm,zed" # Directories symlinked into ~/.config

if [[ ! -z $STOW_ROOT_DIRS ]]; then
  for folder in $(echo $STOW_ROOT_DIRS | sed "s/,/ /g")
  do
    log_info "stow linking $folder"
    stow -v -D $folder
    stow -v $folder
  done
fi

if [[ ! -z $STOW_CONFIG_DIRS ]]; then
  # echo "Stow config directories..."
  for folder in $(echo $STOW_CONFIG_DIRS | sed "s/,/ /g")
  do
    log_info "stow linking $folder"
    TARGET_DIR=$HOME/.config/$folder

    mkdir $TARGET_DIR
    stow -v -D $folder
    stow -v -t $TARGET_DIR $folder
  done
fi

# Create Code sub-directories
PLAYGROUND_DIR="$HOME/dev/_playground"
PERSONAL_PROJECTS_DIR="$HOME/dev/_personal_projects"

if [ ! -d "$PLAYGROUND_DIR" ]; then
  log_info "Creating dev playground..."
  mkdir $PLAYGROUND_DIR
fi

if [ ! -d "$PERSONAL_PROJECTS_DIR" ]; then
  log_info "Creating dev directory for personal projects..."
  mkdir $PERSONAL_PROJECTS_DIR
fi

log_info "Setup complete."

exit 0;
