dotfiles
========

Config files and system bootstrap.

## How to bootstrap it

### On a *nix computer

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
source install.sh
```


### On a Windows computer

Using PowerShell:

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
./install.ps1
```

## Rules for settings file

1. Files are grouped in folders.
2. If a file starts with a dot, it'll be linked as such into `$HOME`:

    ~/.bash_alias -> ~/.dotfiles/bash/.bash_alias

3. If a folder contain a file called `.dot`, the *whole folder* will be linked
   as such into `$HOME`:

    ~/.vim -> ~/.dotfiles/vim

    $ ls -1 ~/.dotfiles/vim/
    .dot
    vimrc

    1. If a folder contains a file called `.dot-something`, the folder
       will be linked into `$HOME` with a name of `something`:

           ~/.vimfiles -> ~/.dotfiles/vim

           $ ls -1 ~/.dotfiles/vim/
           .dot-.vimfiles
           vimrc

4. If a folder contains an `_install.cfg` it'll be configured according to its 
   specifications. 
   Read below for configuration directives.

## `_install.cfg` configuration
```
[ALL]
root = ~/.vim

[windows]
root = $USERPROFILE/vimfiles
vsvimrc.vim = $USERPROFILE/vsvimrc.vim

[darwin]
xvimrc.vim = $HOME/xvimrc.vim
```

Specify only certain operating system.
```
[AL]
os = linux,darwin
```

## Update submodules

1. First time: `git submodule update --init --recursive`
2. Afterward: `git submodule foreach git pull origin master`
