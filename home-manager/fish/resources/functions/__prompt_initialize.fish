function __prompt_initialize -d "Initialize prompt module"
    # Store the exit code of the last command
    set --global g_exit_code $status

    # Prompt string to display
    set --global g_prompt_string ""

    # Count only mode (no print)
    set --global g_prompt_start      true
    set --global g_prompt_mode_count false
    set --global g_prompt_count      0
    set --global g_prompt_available  $COLUMNS
end
