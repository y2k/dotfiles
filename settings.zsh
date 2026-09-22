# Edit personal shell settings here. Keep secrets in .zshrc.local.

# Executables, theme and Oh My Zsh plugins.
path=("$HOME/.local/bin" "$HOME/.fzf/bin" /usr/local/bin $path)
[[ -d "$HOME/.opencode/bin" ]] && path=("$HOME/.opencode/bin" $path)
ZSH_THEME="robbyrussell"
plugins=(git z copypath fzf)

SAVEHIST=50000

alias lg=lazygit
alias mc='SHELL=/bin/bash mc'

export OPENCODE_CONFIG=opencode.local.json
export LY2K_PACKAGES_DIR="${LY2K_PACKAGES_DIR:-$HOME/project/packages}"
export OCAMLRUNPARAM=b
export EDITOR=emacs
export VISUAL=emacs
