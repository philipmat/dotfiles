function _dotfiles_install_tmux() {
    local this_path="$1"
    local target="$2"
	echo "TMUX 1=$1, 2=$2"
    linking_me_softly "$this_path/.tmux" "$target/.tmux"
}
