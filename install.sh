#!/usr/bin/env zsh

echo "Starting install script..."

pushd $DOTFILES

if [[ ! -z $STOW_FOLDERS ]]; then
  echo "Stow files and directories..."
  for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
  do
    echo "stow linking $folder"
    stow -D $folder
    stow $folder
  done
  echo "Stow complete."
fi

popd

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "Installing Homebrew bundle..."
brew bundle install --file="~/Brewfile"
