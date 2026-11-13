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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/igor/.opam/opam-init/init.zsh' ]] || source '/Users/igor/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null; true
# END opam configuration

# direnv: per-directory env (e.g. JAVA_HOME for android-otp-app)
# WORKAROUND direnv 2.38.1: its zsh hook skips precmd (ZSH_EVAL_CONTEXT=shfunc), so a new tab
# never loads .envrc until the first cd. https://github.com/direnv/direnv/issues/1633
# Remove (back to plain `eval "$(direnv hook zsh)"`) once a release with
# https://github.com/direnv/direnv/pull/1634 is installed (`direnv version` > 2.38.1).
eval "$(direnv hook zsh | sed 's/!= toplevel(:\[a-z\]#func|)#/!= (toplevel|[a-z]#func)(:[a-z]#func|)#/')"

# metavr
export PATH="$HOME/.metavr/bin:$PATH"

# go install binaries (pops-cli)
export PATH="$HOME/go/bin:$PATH"
