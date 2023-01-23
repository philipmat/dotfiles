# dotfiles

Config files and system bootstrap.

## How to bootstrap it

```sh
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
```

### On a *nix computer

```sh
bash install.sh
```

or better yet

```sh
bash install.sh --verbose --override 
```

### On a Windows computer

Using an *elevated* command prompt (because `mklink` requires admin rights):

```cmd
install.cmd /v /overide
```

### Parameters for install script

- `-v`, `--verbose` - verbose details about the script executions;
- `-o`, `--override` - override existing files (default is to leave existing files alone);
- `-t`, `--test` - does not actual perform the commands that change the file system.

To keep with traditional semantics, on Windows `install.cmd` also accepts `/`-parameters,
e.g. `/v` or `/override`.

## Update submodules

1. First time: `git submodule update --init --recursive`
2. Afterward: `git submodule foreach git pull origin master`
   or `git submodule update --recursive --remote` (after 1.8.2)
   or `git pull --recurse-submodules` (after 1.8.5).

## Install VSCode Extensions

- `extensions-all.txt` contains all the extensions I used over time
- `extensions-common.txt` - most common extensions

On Windows:

```ps1
cat VSCode\extensions.txt | % { code --install-extension $_ }
```

On Linux:

```sh
cat VSCode/extensions.txt | xargs -L 1 code --install-extension
```

## Install Common Programs

### Windows

### MacOS

```sh
brew install \
  bat curlie difftastic exa \
  fd fzf fig jq neovim \
  pyenv \
  ripgrep sqlite \
  starship tmux watch \
  glance kdiff3 rectangle \
  xz
```

Nerd Fonts required for *starship*:

```sh
brew install --cask \
  homebrew/cask-fonts/font-caskaydia-cove-nerd-font \
  homebrew/cask-fonts/font-fira-mono-nerd-font \
  homebrew/cask-fonts/font-victor-mono-nerd-font
```

Other installation steps:

- setup `fzf`: `$(brew --prefix)/opt/fzf/install`
- Install python: `pyenv install 3.10.9`
- install nvim plugins: `nvim --headless +PlugInstall +qa`

Optional: nushell, xonsh

Manual install:

* [oh-my-zsh](https://ohmyz.sh/#install)
* [Bitwarden](https://apps.apple.com/us/app/bitwarden/id1352778147?mt=12)
* [VSCode](https://code.visualstudio.com/)
* [SourceTree](https://www.sourcetreeapp.com/)
* [Fig](https://fig.io/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* [Remote Desktop Beta](https://install.appcenter.ms/orgs/rdmacios-k2vy/apps/microsoft-remote-desktop-for-mac/distribution_groups/all-users-of-microsoft-remote-desktop-for-mac)
* [Battery Monitor](https://apps.apple.com/us/app/battery-monitor-health-info/id836505650?mt=12)