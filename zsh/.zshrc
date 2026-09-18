# Interactive Zsh configuration matching the previous Fish workflow.

export DOCKER_CLI_HINTS=false
export FLYTECTL_CONFIG="$HOME/.flyte/config-sandbox.yaml"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"

# Oh My Zsh provides completion integrations for the tools used in Fish.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
ZSH_PYENV_QUIET=true
plugins=(
  git
  aws
  docker
  docker-compose
  fzf
  golang
  history-substring-search
  kubectl
  minikube
  npm
  poetry
  pyenv
  python
  rust
  virtualenv
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# Load the default Node version, as the Fish bass/nvm integration did.
if (( ! $+functions[nvm] )) && [[ -r "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
fi
if (( $+functions[nvm] )); then
  nvm use default --silent >/dev/null
fi

alias k=kubectl

# Fish-like history: shared between shells, appended incrementally, and searchable
# from the current prefix with the arrow keys.
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt append_history extended_history hist_expire_dups_first
setopt hist_ignore_dups hist_ignore_space inc_append_history share_history

if (( $+widgets[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
fi

# Export KEY=VALUE lines from one or more files.
loadenv() {
  local file line
  for file in "$@"; do
    [[ -r "$file" ]] || { print -u2 "loadenv: cannot read: $file"; return 1; }
    while IFS= read -r line || [[ -n "$line" ]]; do
      [[ -z "$line" || "$line" == [[:space:]]#\#* ]] && continue
      export "$line"
    done < "$file"
  done
}

# Open a directory in a named tmux session, or switch to its existing session.
tmux-sessionizer() {
  local selected="$1"
  [[ -n "$selected" ]] || return 0
  [[ -d "$selected" ]] || { print -u2 "tmux-sessionizer: not a directory: $selected"; return 1; }

  selected="${selected:A}"
  local session_name="${${selected:t}//./_}"

  tmux has-session -t "=$session_name" 2>/dev/null ||
    tmux new-session -d -s "$session_name" -c "$selected"

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "=$session_name"
  else
    tmux attach-session -t "=$session_name" </dev/tty
  fi
}

# Pick a file in the current directory and edit it in Neovim.
vf() {
  local file
  file=$(find . -maxdepth 1 -type f | fzf --preview='bat --color=always -- {}') || return
  [[ -n "$file" ]] && nvim "$file"
}

_project_session_widget() {
  local selected_dir
  selected_dir=$(find "$HOME/Projects" -maxdepth 3 -type d \
    -not -path '*/.*' \
    -not -path '*/__pycache__' \
    -not -path '*/*.egg-info' | fzf) || return
  tmux-sessionizer "$selected_dir"
  zle reset-prompt
}

_vf_widget() {
  vf
  zle reset-prompt
}

zle -N _project_session_widget
zle -N _vf_widget
bindkey '^F' _project_session_widget
bindkey '^W' _vf_widget

# Sashimi-style prompt ported from Fish, including Git status and command timing.
autoload -Uz add-zsh-hook
zmodload zsh/datetime
typeset -g _command_started_at

_record_command_start() {
  _command_started_at=$EPOCHSECONDS
}

_set_sashimi_prompt() {
  local last_status=$?
  local branch git_info dirty ahead_count behind_count ahead_info initial status_marks

  if [[ -n "$_command_started_at" ]] && (( EPOCHSECONDS - _command_started_at > 300 )); then
    print "The last command took $(( EPOCHSECONDS - _command_started_at )) seconds."
  fi
  _command_started_at=

  if (( last_status == 0 )); then
    initial='%F{green}◆%f'
    status_marks='%f❯%F{cyan}❯%F{green}❯%f'
  else
    initial="%F{red}✖ ${last_status}%f"
    status_marks='%F{red}❯❯❯%f'
  fi

  branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ "$branch" == master ]]; then
      git_info="%f git:(%F{red}${branch}%f)"
    else
      git_info="%f git:(%F{blue}${branch}%f)"
    fi
    dirty=$(command git status --porcelain --ignore-submodules=dirty 2>/dev/null)
    [[ -n "$dirty" ]] && git_info+='%F{yellow} ✗%f'

    local counts
    counts=$(command git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)
    if [[ -n "$counts" ]]; then
      behind_count=${counts%%[[:space:]]*}
      ahead_count=${counts##*[[:space:]]}
      if (( ahead_count > 0 )); then
        ahead_info+="%F{blue}↑${ahead_count}%f "
      fi
      if (( behind_count > 0 )); then
        ahead_info+="%F{red}↓${behind_count}%f "
      fi
    fi
  fi

  PROMPT="${initial} %F{cyan}%1~%f${git_info} ${ahead_info}${status_marks} "
}

add-zsh-hook preexec _record_command_start
add-zsh-hook precmd _set_sashimi_prompt
