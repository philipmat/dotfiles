# dotfiles
========

Config files and system bootstrap.

## How to bootstrap it

```
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
```

### On a *nix computer

```
source install.sh
``` 

or better yet

```
source install.sh --verbose --override 
```

### On a Windows computer

Using an *elevated* command prompt (because `mklink` requires admin rights):

```
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
