if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx DOCKER_CLI_HINTS false
    set -gx FLYTECTL_CONFIG $HOME/.flyte/config-sandbox.yaml
    set -gx NVM_DIR $HOME/.config/nvm
    set -gx PYENV_ROOT $HOME/.pyenv
    set -gx XDG_CONFIG_HOME $HOME/.config

    set -gx fish_user_paths \
        $HOME/.cargo/bin \
        $HOME/go/bin \
        $HOME/.pyenv/bin \
        /opt/homebrew/opt/libpq/bin \
        /opt/homebrew/bin \
        /opt/homebrew/opt \
        $HOME/.venvs/poetry/bin \
        $HOME/.venvs/uv/bin \
        $fish_user_paths
end

set fish_greeting

pyenv init - fish | source

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

alias k kubectl

# nvm
if test -z "$XDG_CONFIG_HOME"
    set -x NVM_DIR "$HOME/.nvm"
else
    set -x NVM_DIR "$XDG_CONFIG_HOME/nvm"
end

# Load nvm only if it's not already loaded
if not type -q nvm
    if test -f ~/.nvm/nvm.sh
        bass source ~/.nvm/nvm.sh ';' nvm use default
    end
end

bind \cf 'find ~/Projects/ -maxdepth 3 -type d -not -path "*/.*" -not -path "*/__pycache__" -not -path "*/*.egg-info" | fzf | read selected_dir; tmux-sessionizer $selected_dir'
bind \cw vf
