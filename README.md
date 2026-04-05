# .dotfiles

My configuration files, for Mac OS.

## Usage

### Leaving a machine

Captures the current Homebrew state into the repo for later use when re-installing.

```bash
./snapshot
```

### Fresh setup

Runs the bootstrap script, installs dependencies, creates symlinks to dotfiles, and creates `dev` directories.

### Bootstrap

```bash
./bootstrap
```

The bootstrap is rerunnable and aborts on conflicts instead of overwriting unmanaged files.

### Legacy scripts

The older scripts are still present while the new flow settles:

```bash
bash setup.sh
bash install.sh
```
