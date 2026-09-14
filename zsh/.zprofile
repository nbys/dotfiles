# Homebrew's environment is needed by login shells (Terminal, SSH, etc.).
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Put pyenv shims on PATH before the interactive shell starts.
if (( $+commands[pyenv] )); then
  eval "$(pyenv init --path)"
fi
