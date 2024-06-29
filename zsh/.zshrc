COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{red}'
COLOR_GIT='%F{green}'
NEWLINE=$'\n'

parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Custom Prompt
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}> '

# Enable case-insensitive auto-complete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Enable Syntax highlighting
# Install: `brew install zsh-syntax-highlighting`
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable zsh-autosuggestions.zsh
# Install: `brew install zsh-autosuggestions`
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias dev="cd $HOME/dev"

alias vim="nvim"

alias soz="source ~/.zshrc"

source ~/.zsh_profile
