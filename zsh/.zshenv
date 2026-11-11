# Environment shared by login, interactive, and script shells.
export ZDOTDIR="$HOME/.config/zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export PYENV_ROOT="$HOME/.pyenv"

# Keep PATH entries unique while preserving the first occurrence.
typeset -U path PATH

# Remove obsolete Homebrew prefix directories inherited from an older shell.
# Only their bin directories belong on PATH.
path=(${path:#/opt/homebrew/opt})
path=(${path:#/usr/local/opt})

# Homebrew lives in different prefixes on Apple Silicon, Intel macOS, and
# Linux. Only add its paths when it is actually installed on this OS.
typeset -a _homebrew_paths
case "$OSTYPE" in
  darwin*)
    if [[ -x /opt/homebrew/bin/brew ]]; then
      _homebrew_prefix=/opt/homebrew
    elif [[ -x /usr/local/bin/brew ]]; then
      _homebrew_prefix=/usr/local
    fi
    ;;
  linux*)
    if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      _homebrew_prefix=/home/linuxbrew/.linuxbrew
    fi
    ;;
esac

if [[ -n "${_homebrew_prefix:-}" ]]; then
  _homebrew_paths+=("$_homebrew_prefix/bin" "$_homebrew_prefix/sbin")
  [[ -d "$_homebrew_prefix/opt/libpq/bin" ]] && \
    _homebrew_paths+=("$_homebrew_prefix/opt/libpq/bin")
fi

path=(
  "${_homebrew_paths[@]}"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/go/bin"
  "$PYENV_ROOT/bin"
  "$HOME/.venvs/poetry/bin"
  "$HOME/.venvs/uv/bin"
  /usr/local/bin
  $path
)

unset _homebrew_paths _homebrew_prefix

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
