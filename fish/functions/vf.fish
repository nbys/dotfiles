function vf
    # Use fzf to select a file from the current directory
    set file (find . -maxdepth 1 -type f | fzf --preview="bat --color=always {}")
    # Check if a file was selected
    if test -n "$file"
        nvim "$file"
    end
end
