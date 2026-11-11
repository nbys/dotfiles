# Homebrew's environment is needed by login shells (Terminal, SSH, etc.).
# Its binary was added conditionally by .zshenv on supported platforms.
if (( $+commands[brew] )); then
  # Pass the shell explicitly while the account's login shell may still be Fish.
  eval "$(brew shellenv zsh)"
fi

# Put pyenv shims on PATH before the interactive shell starts.
if (( $+commands[pyenv] )); then
  eval "$(pyenv init --path zsh)"
fi
