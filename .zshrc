export ZSH="$HOME/.oh-my-zsh"
typeset -U path
path=("$HOME/.local/bin" "$HOME/.fzf/bin" /usr/local/bin $path)
[[ -d "$HOME/.opencode/bin" ]] && path=("$HOME/.opencode/bin" $path)
ZSH_THEME="robbyrussell"
plugins=(git z copypath fzf)

_sdk_paths=()
_sdk_fallbacks=()
_plugin_dirs=()
case "$OSTYPE" in
  darwin*) source "$HOME/.dotfiles/macos/zshrc.zsh" ;;
  linux*) source "$HOME/.dotfiles/linux/zshrc.zsh" ;;
esac

source "$ZSH/oh-my-zsh.sh"

SAVEHIST=50000

alias lg=lazygit
alias mc='SHELL=/bin/bash mc'

export OPENCODE_CONFIG=opencode.local.json
export LY2K_PACKAGES_DIR="${LY2K_PACKAGES_DIR:-$HOME/project/packages}"
export OCAMLRUNPARAM=b
export EDITOR=emacs
export VISUAL=emacs

# Private and machine-local settings (not tracked in Git).
[[ -f ~/.dotfiles/.zshrc.local ]] && source ~/.dotfiles/.zshrc.local

_brew_prefix=""
(( $+commands[brew] )) && _brew_prefix="$(brew --prefix)"
if [[ -n "$_brew_prefix" ]]; then
  _sdk_paths+=("$_brew_prefix/share/android-commandlinetools")
  _plugin_dirs=("$_brew_prefix/share" "${_plugin_dirs[@]}")
fi

# Android SDK
if [[ -z "$ANDROID_HOME" ]]; then
  for _sdk in "${_sdk_paths[@]}" "${_sdk_fallbacks[@]}"; do
    if [[ -d "$_sdk" ]]; then
      export ANDROID_HOME="$_sdk"
      break
    fi
  done
fi
if [[ -n "$ANDROID_HOME" && -d "$ANDROID_HOME" ]]; then
  export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
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
unset _brew_prefix _sdk _plugin _dir _sdk_paths _sdk_fallbacks _plugin_dirs
