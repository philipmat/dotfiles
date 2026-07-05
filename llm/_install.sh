function _dotfiles_install_llm() {
    local dot_path="$1" # typically this folder
    local target="$HOME"
    if [[ "$OSTYPE" == "darwin"* ]]
    then
        target="$HOME/Library/Application Support/io.datasette.llm"
    else
        target="$HOME/.config/io.datasette.llm"
    fi
    mkdir -p "$target"
    # echo "LLM: $dot_path/aliases.json => $target/aliases.json"
    linking_me_softly "$dot_path/templates" "$target/templates"
    linking_me_softly "$dot_path/aliases.json" "$target/aliases.json"
    linking_me_softly "$dot_path/uv-tool-packages.json" "$target/uv-tool-packages.json"
}
