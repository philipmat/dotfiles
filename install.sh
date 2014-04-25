#!/usr/bin/env bash

function linking_me_softly() {
	source=$1
	dest=$2
	echo "Link: $1 => $2"
}


for directory in $(ls -d */) ; do
	if [[ -f ${directory}.dot ]] ; then
		linking_me_softly ${directory%%/} $HOME/.${directory%%/}
	fi
	for dotfile in ${directory}.??* ; do
		basedot=$(basename $dotfile)
		[[ $basedot == '.dot' ]] && continue
		linking_me_softly $dotfile $HOME/$basedot
	done
	if [[ -s ${directory}_install.sh ]] ; then
		cd $directory
		source _install.sh
		cd ..
	fi
done
