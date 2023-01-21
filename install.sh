#!/usr/bin/env bash
TEST=false
VERBOSE=false
OVERRIDE=false
LN_FLAGS=-sfFn

[ "$(uname)" == 'Linux' ] && LN_FLAGS=-sfn

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
	if [ -e "$2" ] ; then
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

	ln $LN_FLAGS $real_source "$2"
}

# init the submodules
( [ "$VERBOSE" = "true" ] || [ "$TEST" = "true" ] ) && echo "Updating git submodules."
if [ "$TEST" = "false" ] ; then
	echo "Updating git"
	# git submodule update --init
	# git submodule update --recursive --remote
fi

# file links
file_links=(bash ctags hg python tmux)

for directory in $(ls -d */) ; do
	dir=${directory%%/}
	[[ $VERBOSE == true ]] && echo -e "\nHandling $dir:"
	if [[ -s $dir/_install.sh ]] ; then
		cd $directory
		source _install.sh
		# this should import a _dotfiles_install_$directory function into the space
		basedot=$(basename $directory)
		install_func="_dotfiles_install_$basedot"
		[[ $VERBOSE == true ]] && echo "Installing according to $dir/_install.sh::$install_func."
		install_from="$(pwd)"
		echo "install_to=$dir=$install_from"
		[[ $(type -t $install_func) == 'function' ]] && eval $install_func "$install_from" "$HOME"
		unset install_func
		cd ..
	fi
done

#####################
# supplemental bash
#####################
URL=https://raw.githubusercontent.com/git/git/master/contrib/completion
wget "$URL/git-completion.bash" -O $HOME/git-completion.bash
wget "$URL/git-completion.zsh" -O $HOME/git-completion.zsh
unset URL

#####################
# zsh. First install oh-my-zsh, then link our zshrc
# This is because oh-my-zsh overrides zshrc anyway
#####################
[ "$VERBOSE" = "true" ] && echo "Installing zshrc"
if [ "$(uname)" == 'Darwin' ] ; then

	if [ ! -d "$HOME/.oh-my-zsh" ] ; then
		[ "$VERBOSE" = "true" ] && echo "Installing oh-my-zsh"
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	else
		[ "$VERBOSE" = "true" ] && echo "oh-my-zsh already installed at $HOME/.oh-my-zsh"
	fi

	[ "$VERBOSE" = "true" ] && echo "Linking .zshrc"
	linking_me_softly "zsh/.zshrc" "$HOME/.zshrc"
fi


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


###############
# VSCode
###############
[ "$VERBOSE" = "true" ] && echo "Linking VSCode settings"
if [ "$(uname)" == 'Darwin' ] ; then
	[ "$VERBOSE" = "true" ] && echo "Linking VSCode settings"
    linking_me_softly "VSCode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
    linking_me_softly "VSCode/snippets" "$HOME/Library/Application Support/Code/User/snippets"
    linking_me_softly "VSCode/settings.json" "$HOME/Library/Application Support/Code - Insiders/User/settings.json"
    linking_me_softly "VSCode/snippets" "$HOME/Library/Application Support/Code - Insiders/User/snippets"
fi

unset LN_FLAGS OVERRIDE TEST VERBOSE