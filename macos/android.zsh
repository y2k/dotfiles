export ANDROID_HOME="${ANDROID_HOME:-/opt/homebrew/share/android-commandlinetools}"

if [[ -d "$ANDROID_HOME" ]]; then
  path=("$ANDROID_HOME/platform-tools" "$ANDROID_HOME/cmdline-tools/latest/bin" $path)
fi
