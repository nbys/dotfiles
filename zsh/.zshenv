# Environment shared by login, interactive, and script shells.
export ZDOTDIR="$HOME/.config/zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export PYENV_ROOT="$HOME/.pyenv"

# Keep PATH entries unique while preserving the first occurrence.
typeset -U path PATH
path=(
  "$HOME/.cargo/bin"
  "$HOME/go/bin"
  "$PYENV_ROOT/bin"
  /opt/homebrew/opt/libpq/bin
  /opt/homebrew/bin
  /opt/homebrew/opt
  "$HOME/.venvs/poetry/bin"
  "$HOME/.venvs/uv/bin"
  /usr/local/bin
  $path
)

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
