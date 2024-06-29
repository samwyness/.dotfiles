#!/usr/bin/env zsh

echo "Starting install script..."

pushd $DOTFILES
echo "Stow files and directories..."
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "stow linking $folder"
    stow -D $folder
    stow $folder
done
echo "Stow complete."
popd

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "Installing Homebrew bundle..."
brew bundle --file $DOTFILES/homebrew/Brewfile
