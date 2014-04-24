#!/usr/bin/env bash

for directory in $(ls -d */) ; do
	if [[ -s ${directory}_install.sh ]] ; then
		cd $directory
		source _install.sh
		cd ..
	fi
done
