export ZSH="$HOME/.oh-my-zsh"
typeset -U path
path=("$HOME/.local/bin" "$HOME/.fzf/bin" /usr/local/bin $path)
ZSH_THEME="robbyrussell"
plugins=(git z copypath fzf)
[[ "$OSTYPE" == darwin* ]] && plugins+=(macos)

source "$ZSH/oh-my-zsh.sh"

SAVEHIST=50000

alias mac_gc="find . -type f \( -name '.DS_Store' -o -name '._*' \) -delete"
alias lg=lazygit
alias mc='SHELL=/bin/bash mc'

export OPENCODE_CONFIG=opencode.local.json
export LY2K_PACKAGES_DIR="${LY2K_PACKAGES_DIR:-$HOME/project/packages}"
export OCAMLRUNPARAM=b
export COPYFILE_DISABLE=1
export EDITOR=emacs
export VISUAL=emacs

# Private and machine-local settings (not tracked in Git).
[[ -f ~/.dotfiles/.zshrc.local ]] && source ~/.dotfiles/.zshrc.local

_brew_prefix=""
(( $+commands[brew] )) && _brew_prefix="$(brew --prefix)"

# Android SDK
if [[ -z "$ANDROID_HOME" ]]; then
  for _sdk in "$HOME/Library/Android/sdk" "$HOME/Android/Sdk" \
    "${_brew_prefix:-/opt/homebrew}/share/android-commandlinetools" \
    /usr/local/share/android-commandlinetools; do
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
    "${_brew_prefix:-/opt/homebrew}/share" /usr/local/share /usr/share; do
    if [[ -r "$_dir/$_plugin/$_plugin.zsh" ]]; then
      source "$_dir/$_plugin/$_plugin.zsh"
      break
    fi
  done
done
unset _brew_prefix _sdk _plugin _dir

# opencode
export PATH=/home/userland/.opencode/bin:$PATH
