function _dotfiles_install_tmux() {
    local dot_path="$1"
    local target="$2"
    # linking_me_softly .tmux $HOME/.tmux
    linking_me_softly "$dot_path/tmux/.tmux" "$target/.tmux"
}