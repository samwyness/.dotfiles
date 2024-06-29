CONFIG_HOME := $(HOME)/.config/

ifeq ($(DOTFILES),)
	DOTFILES := $(HOME)/.dotfiles
endif

ifeq ($(STOW_FOLDERS),)
	STOW_FOLDERS := git zsh wezterm nvim
endif

ifeq ($(NVIM_HOME),)
	NVIM_HOME := $(CONFIG_HOME)/nvim
endif

DOTFILES := $(DOTFILES)
STOW_FOLDERS := $(STOW_FOLDERS) 
NVIM_HOME := $(NVM_HOME) 

help: ## Print help message
	@# Thanks to tweekmonster.
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\033[36m\1\\033[m:\2/' | column -c2 -t -s :)"

.PHONY = all 

all: install stow

install: ## Installs default tools
	@echo "Installing tools"

stow: ## Create symlinks for stow directories
		@echo "Let's stow [$(strip $(STOW_FOLDERS))]\n"
		@stow --delete $(STOW_FOLDERS)
		@stow --target $(HOME) --verbose $(STOW_FOLDERS)
		@echo "\nStow completed [$(strip $(STOW_FOLDERS))]\n"

