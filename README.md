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

Extensions have been exported with `code --list-extensions`
and sorted case-insensitive (`sort -f`).

On Windows:

```ps1
cat VSCode\extensions.txt | % { code --install-extension $_ }
```

On Linux:

```sh
cat VSCode/extensions-common.txt | xargs -L 1 code --install-extension
```

## Install Common Programs

### Windows

- PowerShell 7
- Scoop
- PowerToys
- WindowGrid

```ps
scoop install git
scoop bucket aff extras
```

### MacOS

```sh
brew install \
  bat btop \
  difftastic eza \
  fd fzf gh fnm \
  gron \
  iterm2 \
  jq \
  kdiff3 \
  lazygit localsend \
  neovim nono \
  pyenv pstree \
  ripgrep \
  sqlite smartmontools starship \
  tmux uv \
  watch watchexec wget2 \
  xz
```

Optional:

```sh
brew install \
  dos2unix \
  glance \
  unixodbc msodbcsql18 mssql-tools18 \
  node qrencode \
  orbstack \
  opencode opencode-desktop \
  pi-coding-agent  \
  sshpass \
  unixodbc \
  darrylmorley/whatcable/whatcable-cli
```

```sh
brew install --cask claude-code temurin transmission opencode-desktop codex
```

Nerd Fonts required for *starship*:

```sh
brew install --cask \
  homebrew/cask-fonts/font-caskaydia-cove-nerd-font \
  homebrew/cask-fonts/font-fira-mono-nerd-font \
  homebrew/cask-fonts/font-victor-mono-nerd-font \
  homebrew/cask-fonts/font-maple-mono \
  homebrew/cask-fonts/font-maple-mono-nf \
  homebrew/cask-fonts/font-jetbrains-mono-nerd-font
```

Other installation steps:

- setup `fzf`: `$(brew --prefix)/opt/fzf/install`
- Install python: `pyenv install 3.14`
- install nvim plugins: `nvim --headless +PlugInstall +qa`

Manual install:

- [VSCode](https://code.visualstudio.com/)
- [Zed](https://zed.dev/)
- [Battery Monitor](https://apps.apple.com/us/app/battery-monitor-health-info/id836505650?mt=12)
- [Rectangle Pro](https://rectangleapp.com/pro/)
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
- [DaisyDisk](https://daisydiskapp.com/); alternative: [Grand Perspective](https://grandperspectiv.sourceforge.net/)
- [Nimble Commander](https://magnumbytes.com/)
- [NetNewsWire](https://netnewswire.com/)
- [LINQPad](https://www.linqpad.net/)
