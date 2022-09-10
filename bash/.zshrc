
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
setopt HIST_IGNORE_SPACE autocd autopushd histignoredups

function mkcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1" ; }

PROMPT="[ %B%~%b ] %* %n@%m"$'\n'"%# "

alias d='ls -al'
