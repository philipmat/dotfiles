[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_completion ]] && . ~/.bash_completion
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi


# START_PATH_COLOR='\e[0;30m\e[47m'
# START_PATH_COLOR="$(tput rev)$(tput bold)"
# START_PATH_COLOR="$(tput bold)"
START_PATH_COLOR='\e[1m'
END_PATH_COLOR='\e[2m'
# END_COLOR="$(tput sgr0)"
END_COLOR='\e[0m'
export PS1="[\[$START_PATH_COLOR\] \w \[$END_COLOR\]] \t \u@\h\n\$\[$END_COLOR\] "
# export PS1="[ \w ] \t \u@\h\n\$ "
export PS2='PS2\$ '
export PATH=.:~/bin:$PATH
export EDITOR=vim
export HISTCONTROL=ignoreboth
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

function mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1" ; }
function qv() { 
	qlmanage -p "$@" >& /dev/null 
}





### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
