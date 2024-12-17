# .dotfiles

My configuration files, for Mac OS.

## Usage

### Leaving a machine

Dumps the current Homebrew dependencies to a file for later use when re-installing.

```bash
brew bundle dump --file ./homebrew/Brewfile --force
```

### Fresh setup

Runs the installation script, creates symlinks to dotfiles, and creates `dev` directories.

### Setup

```bash
bash setup.sh
```

### Install dependencies

Installs [Homebrew](https://brew.sh/) and [Brewfile](https://github.com/Homebrew/homebrew-bundle) dependencies.

```bash
bash install.sh
```

> [!NOTE]
> Installation is run in the `setup.sh` script
