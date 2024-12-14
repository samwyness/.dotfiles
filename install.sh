SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Include the logger
source "$SCRIPT_DIR"/logger.sh

# Check for Homebrew and install if we don't have it, otherwise update
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  log_info 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi

# Install all our dependencies with bundle (See Brewfile)
log_info "Installing Homebrew bundle..."
brew bundle install --file="$SCRIPT_DIR/homebrew/Brewfile"
