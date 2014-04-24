#!/usr/bin/env bash

# current folder should be vim
install_name=$(basename ${BASH_SOURCE:-_install.sh})
for rc in *.sh ; do
	[[ $install_name == $rc ]] && continue
	homefile=$HOME/.${rc%.sh}
	linking_me_softly "$rc" "$homefile"
done

