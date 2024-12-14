#!/usr/bin/env zsh

log_info() {
  COLOR_NC='\033[0m'
  COLOR_CYAN='\033[0;36m'
  echo -e "${COLOR_CYAN}info${COLOR_NC} $1"
}
