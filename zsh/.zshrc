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

# TODO: live without oh-my-zsh for a while
# search for #~ it needed to uncomment
#~ plugins=(dotenv copypath git git-prompt history-substring-search python)

# Disable compinit warnings
#~ ZSH_DISABLE_COMPFIX="true"

# Fuzzy search for history
# ^r: ab c searches for "*ab*c*"
HISTORY_SUBSTRING_SEARCH_FUZZY='yes'
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
setopt HIST_IGNORE_SPACE autocd autopushd histignoredups

# dotenv options
ZSH_DOTENV_FILE=.dotenv
ZSH_DOTENV_PROMPT=false

# case-insensitive completion
autoload -U compinit colors; compinit
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# only show files when autocomp on vim command
zstyle ':completion:*:vim:*' file-name modification

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _approximate _ignored
# corrections in a different color
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# list all file details and with colors
zstyle ':completion:*' file-list all
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

# complete on partial list
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' max-errors 3
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle :compinstall filename '/Users/philip/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall


# autocd for frequent locations
cdpath=($HOME/Projects/InTech $HOME/Projects)

#~ source $ZSH/oh-my-zsh.sh

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
if [[ "$OSTYPE" == "darwin"* ]] && command -v brew > /dev/null
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
elif [[ "$OSTYPE" == "linux"* ]] && ! command -v brew > /dev/null
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export PATH="$PATH:$HOME/.dotnet/tools"
export DOTNET_CLI_TELEMETRY_OPTOUT=1


# nvim support
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fnm support
if command -v fnm >/dev/null
then
	eval "$(fnm env --use-on-cd)"
fi

# fnm creates a bunch of links into $FNM_MULTISHELL_PATH = ~/.local/state/fnm_multishells
# one link per shell instance and it never cleans them up
# this function attempts to do that on shell exit
cleanup_fnm() {
  if [[ -n "$FNM_MULTISHELL_PATH" && -d "$FNM_MULTISHELL_PATH" ]]; then
    rm -rf "$FNM_MULTISHELL_PATH"
  fi
}
trap cleanup_fnm EXIT

###################################################################
# ALIASES
###################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
export EDITOR=vim
if command -v nvim > /dev/null
then
    alias vim="nvim"
    export EDITOR=nvim
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
alias HG="history | rgi "
alias HF="history | fzf "
alias rgi="rg -i"
alias rgj="rg -tjs -i"
alias rgni="rg --no-ignore"
alias ungron="gron --ungron"
alias mkenv='python -m venv .venv'
alias split-path="echo $PATH | tr ':' '\n'"
alias ze="vim ~/.zshrc && source ~/.zshrc"

# note: on linux fd is sudo apt install fd-find
if command -v fd > /dev/null
then
	alias fd-all="fd --hidden --no-ignore"
elif command -v fdfind > /dev/null
then
	alias fd="fdfind"
	alias fd-all="fdfind --hidden --no-ignore"
fi

if command -v lazygit > /dev/null
then
    alias gg="lazygit"
fi

if command -v llm > /dev/null
then
    alias llm-upgrade="llm install -U llm"
    alias llm-1="llm -t one-liner "
    alias llm-short="llm -t brief "
    alias llm-brief="llm -t brief "
    alias llm-cmd="llm cmd --model 'openrouter/openrouter/pareto-code'"
    # use a quick model for HN summaries
    # alias llm-hn='f(){ local id="${1##*id=}"; id="${id%%[^0-9]*}" ; llm -m openrouter/meta-llama/llama-3.1-8b-instruct -f hn:$id "summary with illustrative direct quotes";  unset -f f; }; f'
    # alias llm-hn='f(){ local id="${1##*id=}"; id="${id%%[^0-9]*}" ; llm -m openrouter/openrouter/free -f hn:$id "summary with illustrative direct quotes; do not use markdown tables" | rich -w 100 -m - ;  unset -f f; }; f'

	# hn-summary.yaml
	#prompt: >
  	#  summary with illustrative direct quotes; include a sentiment analysis with percentages at the end;
  	#  DO NOT USE MARKDOWN TABLES. print your model name at the end as a signature
    # install rich with uv-tool-install rich-cli and then
    # ln -s ~/.local/share/uv/tools/rich-cli/bin/rich ~/.local/bin/rich
	llm-hn() {
		local id="${1##*id=}"
		local id="${id%%[^0-9]*}"
		local model="openrouter/openrouter/free"
		# local model="openrouter/google/gemma-4-31b-it:free"
		# local model="openrouter/openai/gpt-oss-120b:free"

		llm -m $model -f hn:$id \
			-t hn-summary \
			| rich -w 100 -m -
	}

    source ~/Projects/dotfiles/autocompletions/llm.completions.sh
fi

if command -v nono > /dev/null
then
	alias no-opencode="nono run --profile opencode2 --allow . -- opencode"
	alias no-claude="nono run --profile claude -- claude --dangerously-skip-permissions"
	alias no-claude-az="CLAUDE_CONFIG_DIR=~/.claude-az nono run --profile claude -- claude --dangerously-skip-permissions"
	# alias no-pi="nono run --profile pi --allow . -- pi --provider openrouter"
	# use ~/.local/bin/no-codex because it needs env vars
	#alias no-codex="nono run --profile codex --allow . -- codex"
	no-pi() {
    	local extra_args=()
    	local git_dir

    	if git_dir="$(git rev-parse --absolute-git-dir 2>/dev/null)"; then
      	  extra_args+=(--read-file "$git_dir/commondir")
    	fi

    	nono run --profile pi --allow . "${extra_args[@]}" -- pi --provider openrouter "$@"
  }
fi

if command -v claude > /dev/null
then
	alias clauded="claude --dangerously-skip-permissions"
	# create a settings.nosandbox.json with ' { "sandbox": { "enabled": false } } '
	alias claude-nosandbox='claude --settings ~/.claude/settings.nosandbox.json'
fi

alias whatsmyip="dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com"
if [[ "$OSTYPE" == "darwin"* ]]
then
    alias speedtest="networkQuality"
fi
alias brew-list-desc="brew list --formula | xargs -n1 brew desc"
alias path-split='echo $PATH | tr ":" "\n" | sort'


if [[ "$OSTYPE" == "linux-gnu" ]] ; then
	if command -v podman > /dev/null ; then
		alias docker='podman'
	fi
fi
# Functions for interactive mode
# For non-interactive mode, place functions in ~/.zshenv
function mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1" ; }

# aws completion
#
# [ -f "$(brew --prefix)/share/zsh/site-functions/aws_zsh_completer.sh" ] && source "$(brew --prefix)/share/zsh/site-functions/aws_zsh_completer.sh"

# Load local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# load SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -f ~/.sdkman/bn/sdkman-init.sh ] && source ~/.sdkman/bin/sdkman-init.sh

autoload zmv

#if command -v pyenv >/dev/null
#then
#    export PYENV_ROOT="$HOME/.pyenv"
#    export PATH="$PYENV_ROOT/bin:$PATH"
#    eval "$(pyenv init -)"
#fi

# uv instead of pyenv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# TODO: maybe https://github.com/willkg/dotfiles/blob/main/dotfiles/bin/uv-python-symlink

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# loads SDKMAN
#~ source "$HOME/.sdkman/bin/sdkman-init.sh"

# Starship prompt
eval "$(starship init zsh)"

# iTerm2 shell integration (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]
then
    ITERM2_SQUELCH_MARK=1
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# load SSH on linux
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
# if [[ "$OSTYPE" == "linux-gnu" ]] ; then
# 	SSH_ENV="$HOME/.ssh/environment"
#
# 	function start_agent() {
#      	 echo "Initialising new SSH agent..."
#      	 /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#      	 echo succeeded
#      	 chmod 600 "${SSH_ENV}"
#      	 . "${SSH_ENV}" > /dev/null
#      	 /usr/bin/ssh-add;
# 	}
#
# 	# Source SSH settings, if applicable
#
# 	if [ -f "${SSH_ENV}" ]; then
#      	 . "${SSH_ENV}" > /dev/null
#      	 #ps ${SSH_AGENT_PID} doesn't work under cywgin
#      	 ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#          	 start_agent;
#      	 }
# 	else
# 		start_agent;
# 	fi
# fi
