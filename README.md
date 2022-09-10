# dotfiles

Config files and system bootstrap.

## How to bootstrap it

```sh
git clone https://github.com/philipmat/dotfiles .dotfiles
cd .dotfiles/
```

### On a *nix computer

```sh
source install.sh
```

or better yet

```sh
source install.sh --verbose --override 
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
