#!/usr/bin/env zsh

log_info() {
  local color_nc='\033[0m'
  local color_cyan='\033[0;36m'
  echo -e "${color_cyan}info${color_nc} $1"
}

log_error() {
  local color_nc='\033[0m'
  local color_red='\033[0;31m'
  echo -e "${color_red}error${color_nc} $1" >&2
}

die() {
  log_error "$1"
  exit 1
}

ensure_command() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

load_homebrew_env() {
  if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv zsh)"
  elif [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv zsh)"
  else
    return 1
  fi
}
