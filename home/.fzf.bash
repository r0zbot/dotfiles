# Setup fzf
# ---------
if [[ ! "$PATH" == */home/r0zbot/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/r0zbot/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/r0zbot/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/r0zbot/.fzf/shell/key-bindings.bash"
