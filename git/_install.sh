function _dotfiles_install_git() {
    local dot_path="$1"  
    local target="$2"

    linking_me_softly "$dot_path/git/.gitconfig" "$target/.gitconfig"
    linking_me_softly "$dot_path/git/.gitignore_global" "$target/.gitignore_global"
    linking_me_softly "$dot_path/git/.git-prompt.sh" "$target/.git-prompt.sh"
    [[ $(uname) == 'Darwin' ]] && \
        linking_me_softly "$dot_path/git/.gitconfig-osx" "$target/.gitconfig-extra"
    
    [[ $(uname) == 'Linux' ]] && \
        linking_me_softly "$dot_path/git/.gitconfig-linux" "$target/.gitconfig-extra"

}