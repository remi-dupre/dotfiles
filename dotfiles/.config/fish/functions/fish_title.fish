function fish_title
    # Fetch current command name
    set -q argv[1]; or set argv fish

    # Echo path and command
    echo -n (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;


    # Add niceness if non-standard
    if test (nice) != "0"
        echo -n "  ★" (nice)
    end

    echo ""
end
