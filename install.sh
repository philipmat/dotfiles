#!/bin/sh
TEST=false
VERBOSE=false
OVERRIDE=false
LN_FLAGS=-sfFn

[ $(uname) == 'Linux' ] && LN_FLAGS=-sfn

for i in "$@" ; do
	case $i in
		"-t"|"--test")
			TEST=true
			;;
		"-v"|"--verbose")
			VERBOSE=true
			;;
		"-o"|"--override")
			OVERRIDE=true
			;;
		*)
			;;
	esac
	shift
done
unset i
get_abs_filename() {
	# generate absolute path from relative path
	# $1     : relative filename
	# return : absolute path
	# >&2 echo "ABS 0=$1"
	if [ -d "$1" ]; then
    	# dir
    	# >&2 echo "ABS 1. $(cd "$1"; pwd)"
    	echo "$(cd "$1"; pwd)"
	elif [ -f "$1" ]; then
    	# file
    	if [ "$1" = "*/*" ]; then
        	# >&2 echo "ABS 2. $(cd "${1%/*}"; pwd)/${1##*/}"
        	echo "$(cd "${1%/*}"; pwd)/${1##*/}"
    	else
        	# >&2 echo "ABS 3. $(pwd)/$1"
        	echo "$(pwd)/$1"
    	fi
	fi
}

linking_me_softly() {
	# $1 = source, $2 = destination
	local real_source="$(get_abs_filename "$1")"
	# echo "linking_me_softly: 1=$1, 2=$2, real=$real_source."
    if [ -z $real_source ] ; then
		[ "$VERBOSE" = "true" ] && echo "Cannot find absolute path for $1. File might not exist."
		return
	fi
	( [ "$VERBOSE" = "true" ] || [ "$TEST" = "true" ] ) && echo "Link: $real_source => $2"
	if [ -e $2 ] ; then
		if [ "$OVERRIDE" = "false" ] ; then
			[ "$VERBOSE" = "true" ] && echo "Skipping: $2 already exists."
			return
		fi
	fi	
	if [ "$TEST" = "true" ] ; then
		echo "Test only"
		# echo "Test only TEST=$TEST"
		# [ "false" = "true" ] && echo "false=true"
		# [ "true" = "true" ] && echo "true=true"
		# [ "$TEST" = "true" ] && echo "TEST=true"
		# [ "$TEST" = "false" ] && echo "TEST=false"
		return
	fi
	ln $LN_FLAGS $real_source $2
}

# init the submodules
( [ "$VERBOSE" = "true" ] || [ "$TEST" = "true" ] ) && echo "Updating git submodules."
if [ "$TEST" = "false" ] ; then
	echo "Updating git"
	# git submodule update --init
	# git submodule update --recursive --remote
fi

# echo "OVERRIDE=$OVERRIDE, TEST=$TEST, VERBOSE=$VERBOSE"

DIRECTS="bash ctags hg python tmux"

for d in $DIRECTS ; do
	[ "$VERBOSE" = "true" ] && echo "Processing $d"

	for f in $d/.??* ; do
		linking_me_softly $f $HOME/$(basename $f)
	done
	unset f
done
unset d DIRECTS


###############
# git
###############
[ "$VERBOSE" = "true" ] && echo "Installing git configuration"
GIT="git-prompt.sh gitconfig gitignore_global git_template"
for f in $GIT ; do 
	linking_me_softly "git/.$f" $HOME/.$f
done
unset f

[ "$(uname)" == 'Darwin' ] && \
    linking_me_softly "git/.gitconfig-osx" "$HOME/.gitconfig-extra"

[ "$(uname)" == 'Linux' ] && \
    linking_me_softly "git/.gitconfig-linux" "$HOME/.gitconfig-extra"
unset GIT


###############
# VIM
###############
[ "$VERBOSE" = "true" ] && echo "Installing vim configuration"
linking_me_softly "vim" "$HOME/.vim"

[ "$(uname)" == 'Darwin' ] && \
    linking_me_softly "vim/xvimrc.vim" "$HOME/.xvimrc"

unset LN_FLAGS OVERRIDE TEST VERBOSE
