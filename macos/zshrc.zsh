plugins+=(macos)
alias mac_gc="find . -type f \( -name '.DS_Store' -o -name '._*' \) -delete"
export COPYFILE_DISABLE=1

_sdk_paths=("$HOME/Library/Android/sdk")
_sdk_fallbacks=(/opt/homebrew/share/android-commandlinetools /usr/local/share/android-commandlinetools)
_plugin_dirs=(/opt/homebrew/share /usr/local/share)
