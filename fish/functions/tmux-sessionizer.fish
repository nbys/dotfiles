#!/usr/bin/env fish

# Function to open the selected directory in a tmux session
function tmux-sessionizer --argument dir
    # Get the selected directory from the argument
    set selected $argv[1]

    # Validate input
    if test -z "$selected"
        return 0
    end

    # Extract a session name from the directory
    set selected_name (basename "$dir" | tr './' '__')

    # Check if tmux is running
    set tmux_running (pgrep tmux)

    # If not in a tmux session and tmux is not running, create a new session and exit
    if test -z "$tmux_running"
        tmux new-session -s $selected_name -c $selected
        return 0
    end

    # If the tmux session does not exist, create it
    if not tmux has-session -t=$selected_name 2> /dev/null
        tmux new-session -ds $selected_name -c $selected
    end

    # Attach to the session if outside a tmux client
    if test -z "$TMUX"
        tmux attach-session -t $selected_name
    else
        # Switch to the session if inside a tmux client
        tmux switch-client -t $selected_name
    end
end
