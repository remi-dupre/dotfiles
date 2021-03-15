# Setup fzf
# ---------
if [[ ! "$PATH" == */home/remi/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/remi/.fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/home/remi/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/remi/.fzf/shell/key-bindings.zsh"
