export ZSH="$HOME/.oh-my-zsh"
typeset -U path
source "$HOME/.dotfiles/settings.zsh"

# Private and machine-local settings (not tracked in Git).
[[ -f ~/.dotfiles/.zshrc.local ]] && source ~/.dotfiles/.zshrc.local

_brew_prefix=""
(( $+commands[brew] )) && _brew_prefix="$(brew --prefix)"

_plugin_dirs=()
case "$OSTYPE" in
  darwin*) source "$HOME/.dotfiles/macos/zshrc.zsh" ;;
  linux*) source "$HOME/.dotfiles/linux/zshrc.zsh" ;;
esac

source "$ZSH/oh-my-zsh.sh"

if [[ -n "$_brew_prefix" ]]; then
  _plugin_dirs=("$_brew_prefix/share" "${_plugin_dirs[@]}")
fi

# BEGIN opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null; true
# END opam configuration

# Load installed plugins; syntax highlighting must come last.
for _plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  for _dir in "${ZSH_CUSTOM:-$ZSH/custom}/plugins" \
    "${_plugin_dirs[@]}"; do
    if [[ -r "$_dir/$_plugin/$_plugin.zsh" ]]; then
      source "$_dir/$_plugin/$_plugin.zsh"
      break
    fi
  done
done
unset _brew_prefix _plugin _dir _plugin_dirs
