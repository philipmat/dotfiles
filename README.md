dotfiles
========

Config files and system bootstrap.

## How to bootstrap it

Python is required. This program was tested against v2.7 and v3.5.

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
python install.py
```


## Rules for settings file

1. Files are grouped in folders.
2. If a file starts with a dot, it'll be linked as such into `$HOME`:

    ~/.bash_alias -> ~/.dotfiles/bash/.bash_alias

3. Folders can contain marker files that affect how the whole folder is treated,
   rather than the individual files:
   
   1. If there is a file called `.dot`, the *whole folder* will be linked
      as such into `$HOME`:

            ~/.vim -> ~/.dotfiles/vim

            $ ls -1 ~/.dotfiles/vim/
            .dot
            vimrc

    2. If a folder contains a file called `.dot-something`, the folder
       will be linked into `$HOME` with a name of `something`:

           ~/.vimfiles -> ~/.dotfiles/vim

           $ ls -1 ~/.dotfiles/vim/
           .dot-.vimfiles
           vimrc
    
    3. Add a `.exclude` file to completely ignore a folder,
       that is to indicate that folder does not contain settings.

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

Specify only certain operating system(s).
```
[AL]
os = linux,darwin
```

## Update submodules

1. First time: `git submodule update --init --recursive`
2. Afterward: `git submodule foreach git pull origin master`
