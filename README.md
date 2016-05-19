dotfiles
========

Config files and system bootstrap.

## How to bootstrap it

### On a *nix computer

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
source install.sh # --verbose --override
```


### On a Windows computer

Using an *elevated* command prompt (because `mklink` requires admin rights):

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
install.cmd /v /overide
```

### Parameters for install script
- `-v`, `--verbose` - verbose details about the script executions;
- `-o`, `--override` - override existing files (default is to leave existing files alone);
- `-t`, `--test` - does not actual perform the commands that change the file system.

To keep with traditional semantics, on Windows `install.cmd` also accepts `/`-parameters, 
e.g. `/v` or `/override`. 

## Rules for settings file on non-Windows systems

1. Files are grouped in folders.
2. If a file starts with a dot, it'll be linked as such into `$HOME`:

    ~/.bash_alias -> ~/.dotfiles/bash/.bash_alias

3. If a folder contain a file called `.dot`, the folder will be linked
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

4. If a folder contains an `_install.sh` it'll be sourced during the install.

## Update submodules

1. First time: `git submodule update --init --recursive`
2. Afterward: `git submodule foreach git pull origin master`
