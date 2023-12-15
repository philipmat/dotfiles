# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fd dotenv copypath git git-prompt history-substring-search python)

# Disable compinit warnings
ZSH_DISABLE_COMPFIX="true"

# Fuzzy search for history
# ^r: ab c searches for "*ab*c*"
HISTORY_SUBSTRING_SEARCH_FUZZY='yes'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
setopt HIST_IGNORE_SPACE autocd autopushd histignoredups

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ZSH Theme: Based on BIRA
# Colors: 14 = aqua, 8 = grey
local return_code="%(?.%{$fg[green]%}√.%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%F{green}%n@%m%f '
    local user_symbol='$'
fi

local current_dir='%F{14}%~%f '
#local git_branch='$(git_prompt_info)'
local git_branch='$(git_super_status)'
local venv_prompt='$(virtualenv_prompt_info)'
PROMPT="%F{8}╭─[%f ${current_dir}%F{8}]%f ${git_branch}${venv_prompt} %* ${user_host}
%F{8}╰─%f%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"


# git completion
# TODO: https://stackoverflow.com/a/28035917
# [ -f $HOME/git-completion.zsh ] && source ~/git-completion.zsh

#
# requires to build some python version
# brew install xz
if command -v brew > /dev/null
then
    export CPPFLAGS="-I $(brew --prefix xz)/include $CPPFLAGS"
    export CPPFLAGS="-I $(brew --prefix zlib)/include $CPPFLAGS"
    export CPPFLAGS="-I $(brew --prefix openssl)/include $CPPFLAGS"
    export CFLAGS="$CPPFLAGS"
    export LDFLAGS="-L$(brew --prefix xz)/lib $LDFLAGS"
    export LDFLAGS="-L$(brew --prefix zlib)/lib $LDFLAGS"
    export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
    export PKG_CONFIG_PATH="$(brew --prefix xz)/lib/pkgconfig:$PKG_CONFIG_PATH"
    export PKG_CONFIG_PATH="$(brew --prefix zlib)/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

export PATH="$PATH:/Users/philip/.dotnet/tools"

# nvim support
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fnm support
if command -v fnm >/dev/null
then
	eval "$(fnm env --use-on-cd)"
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
if command -v nvim > /dev/null
then
    alias vim="nvim"
fi
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dir="ls -al"
alias ll="ls -al"
alias S="sudo"
alias py="python3"
if command -v eza > /dev/null
then
    alias x="eza -al"
    alias xt="eza -T"
    alias xd="eza -al -d .*"  
else
    alias x="ls -al"
    # alias xt="eza -T"
    alias xd="ls -al -d .*/"  
fi
alias S='sudo'
alias df='df -h'
alias l='less'
alias tmuxa='tmux new -A -s'
alias g='git'
alias H="history"
alias HG="history | ag "
alias HF="history | fzf "
alias rgi="rg -i"
alias rgj="rg -tjs -i"
alias ungron="gron --ungron"


# Functions for interactive mode
# For non-interactive mode, place functions in ~/.zshenv
function mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1" ; }

# aws completion
#
[ -f /opt/homebrew/share/zsh/site-functions/aws_zsh_completer.sh ] && source /opt/homebrew/share/zsh/site-functions/aws_zsh_completer.sh

# Load local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# load SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -f ~/.sdkman/bn/sdkman-init.sh ] && source ~/.sdkman/bin/sdkman-init.sh 

autoload zmv

if command -v pyenv >/dev/null
then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
