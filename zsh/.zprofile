# Homebrew's environment is needed by login shells (Terminal, SSH, etc.).
if [[ -x /opt/homebrew/bin/brew ]]; then
  # Pass the shell explicitly while the account's login shell may still be Fish.
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# Put pyenv shims on PATH before the interactive shell starts.
if (( $+commands[pyenv] )); then
  eval "$(pyenv init --path zsh)"
fi
