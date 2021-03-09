#!/usr/bin/env bash
TEST=false
VERBOSE=false
OVERRIDE=false

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
function get_abs_filename() {
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
    	if [[ $1 == */* ]]; then
        	# >&2 echo "ABS 2. $(cd "${1%/*}"; pwd)/${1##*/}"
        	echo "$(cd "${1%/*}"; pwd)/${1##*/}"
    	else
        	# >&2 echo "ABS 3. $(pwd)/$1"
        	echo "$(pwd)/$1"
    	fi
	fi
}
function linking_me_softly() {
	# $1 = source, $2 = destination
	real_source="$(get_abs_filename "$1")"
	# echo "linking_me_softly: 1=$1, 2=$2, real=$real_source."
    if [[ -z $real_source ]] ; then
		[[ $VERBOSE == true ]] && echo "Cannot find absolute path for $1. File might not exist."
		return
	fi
	[[ $VERBOSE == true || $TEST == true ]] && echo "Link: $real_source => $2"
	if [[ -e $2 ]] ; then
		if [[ $OVERRIDE == false ]] ; then
			[[ $VERBOSE == true ]] && echo "Skipping: $2 already exists."
			return
		fi
	fi	
	if [ $TEST == true ] ; then
		return
	fi
	ln -sfFn $real_source $2
}

# init the submodules
[[ $VERBOSE == true || $TEST == true ]] && echo "Updating git submodules."
if [[ $TEST == false ]] ; then
	git submodule update --init
	git submodule update --recursive --remote
fi

# file links
file_links = (bash ctags hg python tmux)

x=<<<OLD
for d in file_links ; do
	for f in d/.?? ; do
		fdot=$(basename $f)
		linking_me_softly $f $HOME/$f
	done 
done 
OLD

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
	else
		has_dot=false
		if [[ -f $dir/.dot ]] ; then
			has_dot=true
			[[ $VERBOSE == true ]] && echo "Has .dot; will link into $HOME"
			linking_me_softly $dir $HOME/.$dir
		fi
		for dotfile in $dir/.dot-* ; do
			has_dot=true
			[[ ! -f $dotfile ]] && continue
			basedot=$(basename $dotfile)
			newfile=${basedot##.dot-}
			dir=$(dirname $dotfile)
			[[ $VERBOSE == true ]] && echo "Has $basedot; will link $dir into $HOME/$newfile"
			linking_me_softly $dir $HOME/$newfile
		done
		for dotfile in $dir/.??* ; do
			# only link in files
			[[ ! -f $dotfile ]] && continue
			basedot=$(basename $dotfile)
			[[ $basedot == '.dot' || $basedot == .dot-* ]] && continue
			[[ $VERBOSE == true ]] && echo "$basedot is dot-file; will link into $HOME/$basedot"
			linking_me_softly $dotfile $HOME/$basedot
		done
		
	fi
done
