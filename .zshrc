export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git z copypath macos)

source $ZSH/oh-my-zsh.sh

SAVEHIST=50000

alias mac_gc="find . -type f \( -name '.DS_Store' -o -name '._*' \) -delete"
alias lg=lazygit

export OPENCODE_CONFIG=opencode.local.json
export LY2K_PACKAGES_DIR="$HOME/project/packages"
export OCAMLRUNPARAM=b
export COPYFILE_DISABLE=1

# Android SDK
export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# BEGIN opam configuration
[[ ! -r '/Users/igor/.opam/opam-init/init.zsh' ]] || source '/Users/igor/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null; true
# END opam configuration

source <(fzf --zsh)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Private and machine-local settings (not tracked in Git).
[[ -f ~/.dotfiles/.zshrc.local ]] && source ~/.dotfiles/.zshrc.local

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
