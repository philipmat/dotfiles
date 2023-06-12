function _dotfiles_install_nvim() {
    local dot_path="$1" # typically this folder
    local target="$2" # typically $HOME
    mkdir -p "$HOME/.config"
    linking_me_softly "$dot_path" "$HOME/.config/nvim"
}
