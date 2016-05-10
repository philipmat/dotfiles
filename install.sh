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
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}
function linking_me_softly() {
	# $1 = source, $2 = destination
	real_source=$(get_abs_filename $1)
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
	ln -sf $real_source $2
}

# init the submodules
[[ $VERBOSE == true || $TEST == true ]] && echo "Updating git submodules."
if [[ $TEST == false ]] ; then
	git submodule update --init
	git submodule update --recursive --remote
fi

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
		# only link in files
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
