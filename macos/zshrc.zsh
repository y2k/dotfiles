plugins+=(macos)

alias mac_gc="find . -type f \( -name '.DS_Store' -o -name '._*' \) -delete"
alias update_ai="brew update && brew upgrade claude-code@latest opencode-v2 openspec"

export COPYFILE_DISABLE=1

_plugin_dirs=(/opt/homebrew/share /usr/local/share)

source "$HOME/.dotfiles/macos/android.zsh"
