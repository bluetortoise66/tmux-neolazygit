#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CUSTOM_LAZYGIT_CONFIG="$CURRENT_DIR/../lazygit/config.yml"

LAZYGIT_EDITOR="$CURRENT_DIR/editor.sh" # Check usage in lazygit/config.yml
LAZYGIT_CONFIG=$(echo "$(lazygit -cd)/config.yml")

openLazygit () {
    # Gets the pane id from where the script was called
    local LAZYGIT_ORIGIN_PANE=($(tmux display-message -p "#D"))
    
    # Get the current working directory of the pane
    local CURRENT_PATH=$(tmux display-message -p -t $LAZYGIT_ORIGIN_PANE "#{pane_current_path}")

    # Opens a new tmux window running lazygit appending the needed config
    tmux neww -c "$CURRENT_PATH" \
        -e LAZYGIT_EDITOR=$LAZYGIT_EDITOR \
        -e LAZYGIT_ORIGIN_PANE=$LAZYGIT_ORIGIN_PANE \
        lazygit \
        -ucf "$LAZYGIT_CONFIG,$CUSTOM_LAZYGIT_CONFIG"
}

openLazygit
