function _dotfiles_install_git() {
    local dot_path="$1"  
    local target="$2"

	echo "GIT 1=$1, 2=$2"
    linking_me_softly "$dot_path/.gitconfig" "$target/.gitconfig"
    linking_me_softly "$dot_path/.gitignore_global" "$target/.gitignore_global"
    linking_me_softly "$dot_path/.git-prompt.sh" "$target/.git-prompt.sh"
    [[ $(uname) == 'Darwin' ]] && \
        linking_me_softly "$dot_path/.gitconfig-osx" "$target/.gitconfig-extra"
    
    [[ $(uname) == 'Linux' ]] && \
        linking_me_softly "$dot_path/.gitconfig-linux" "$target/.gitconfig-extra"
}
