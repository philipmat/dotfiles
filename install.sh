#!/usr/bin/env bash
TEST=false
VERBOSE=false

for i in "$@" ; do
	case $i in
		"-t"|"--test")
			TEST=true
			;;
		"-v"|"--verbose")
			VERBOSE=true
			;;
		*)
			;;
	esac
	shift
done

function linking_me_softly() {
	source=$1
	dest=$2
	[[ $VERBOSE == true || $TEST == true ]] && echo "Link: $1 => $2"
}


for directory in $(ls -d */) ; do
	dir=${directory%%/}
	[[ $VERBOSE == true ]] && echo "Handling $dir:"
	if [[ -f $dir/.dot ]] ; then
		[[ $VERBOSE == true ]] && echo "Has .dot; will link into $HOME"
		linking_me_softly $dir $HOME/.$dir
	fi
	for dotfile in $dir/.dot-* ; do
		[[ ! -f $dotfile ]] && continue
		basedot=$(basename $dotfile)
		newfile=${basedot##.dot-}
		dir=$(dirname $dotfile)
		[[ $VERBOSE == true ]] && echo "Has $basedot; will link $dir into $HOME/$newfile"
		linking_me_softly $dir $HOME/$newfile
	done
	for dotfile in $dir/.??* ; do
		[[ ! -f $dotfile ]] && continue
		basedot=$(basename $dotfile)
		[[ $basedot == '.dot' || $basedot == .dot-* ]] && continue
		[[ $VERBOSE == true ]] && echo "$basedot is dot-file; will link into $HOME/$basedot"
		linking_me_softly $dotfile $HOME/$basedot
	done
	if [[ -s $dir/_install.sh ]] ; then
		cd $directory
		source _install.sh
		cd ..
	fi
done
