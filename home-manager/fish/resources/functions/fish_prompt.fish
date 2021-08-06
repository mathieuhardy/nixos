function fish_prompt
    __prompt_initialize

    # --------------------------------------------------------------------------
    # Configuration
    # --------------------------------------------------------------------------

    # Global (variables must be defined)
    #   |
    #   | [boolean] c_prompt_prefixes_show    => show prefixes
    #   | [boolean] c_prompt_suffixes_show    => show suffixes
    #   | [string ] c_prompt_default_prefix   => default prefix value
    #   | [string ] c_prompt_default_suffix   => default suffix value
    #   | [color  ] c_prompt_default_color    => default foreground color
    #   | [color  ] c_prompt_default_bgcolor  => default background color
    #   | [list   ] c_prompt_modules          => ordered modules list to show in prompt
    #   |                                        (line_sep, time, user, dir, host, git, exec_time, jobs, exit_code, char)
    __prompt_setconfig c_prompt_prefixes_show   true
    __prompt_setconfig c_prompt_suffixes_show   true
    __prompt_setconfig c_prompt_default_prefix  " "
    __prompt_setconfig c_prompt_default_suffix  " "
    __prompt_setconfig c_prompt_default_color   ""
    __prompt_setconfig c_prompt_default_bgcolor ""
    __prompt_setconfig c_prompt_modules         line_sep user host dir git
    __prompt_setconfig c_prompt_right_modules   exit_code exec_time jobs
    __prompt_setconfig c_prompt_newline_modules char

    # Date/time
    __prompt_setconfig c_time_show         true
    __prompt_setconfig c_date_show         false
    __prompt_setconfig c_date_time_color   "white"
    __prompt_setconfig c_date_time_bgcolor "magenta"

    # User
    __prompt_setconfig c_user_show         true
    __prompt_setconfig c_user_color        "#272727"
    __prompt_setconfig c_user_bgcolor      "grey"
    __prompt_setconfig c_user_color_root   "#272727"
    __prompt_setconfig c_user_bgcolor_root "grey"

    # Host
    __prompt_setconfig c_host_show        needed
    __prompt_setconfig c_host_color       "#eeeeee"
    __prompt_setconfig c_host_bgcolor     "brgrey"
    __prompt_setconfig c_host_color_ssh   "#eeeeee"
    __prompt_setconfig c_host_bgcolor_ssh "brgrey"

    # Dir
    __prompt_setconfig c_dir_show  true
    __prompt_setconfig c_dir_color "green"

    # Git status
    __prompt_setconfig c_git_branch_show  true
    __prompt_setconfig c_git_status_show  true
    __prompt_setconfig c_git_prefix       "["
    __prompt_setconfig c_git_suffix       "] "
    __prompt_setconfig c_git_color        "blue"
    __prompt_setconfig c_git_prompt_order untracked modified added renamed deleted stashed conflict diverged ahead behind

    __prompt_setconfig c_git_status_modified "M"
    __prompt_setconfig c_git_status_added    "A"
    __prompt_setconfig c_git_status_ahead    "+"
    __prompt_setconfig c_git_status_behind   "-"
    __prompt_setconfig c_git_status_diverged "󰘬 "

    # Execution time
    __prompt_setconfig c_exec_time_show        true
    __prompt_setconfig c_exec_time_color       "brgrey"
    __prompt_setconfig c_exec_time_bgcolor     "yellow"
    __prompt_setconfig c_exec_time_min_seconds 1

    # Jobs
    __prompt_setconfig c_jobs_show    true
    __prompt_setconfig c_jobs_color   "white"
    __prompt_setconfig c_jobs_bgcolor "blue"

    # Exit code
    __prompt_setconfig c_exit_code_show    true
    __prompt_setconfig c_exit_code_color   "white"
    __prompt_setconfig c_exit_code_bgcolor "red"
    __prompt_setconfig c_exit_code_symbol "󱈸 "

    # Prompt char
    __prompt_setconfig c_char_symbol "\$"
    __prompt_setconfig c_char_prefix ""

    # --------------------------------------------------------------------------
    # Sections
    # --------------------------------------------------------------------------

    # Left prompt
    # -----------
    for i in $c_prompt_modules
        eval __prompt_$i
    end

    # Right prompt
    # ------------

    # Compute size of content to display on right prompt
    set g_prompt_mode_count true
    for i in $c_prompt_right_modules
        eval __prompt_$i
    end

    # Print padding if needed
    if [ $g_prompt_count -gt 0 ]
        __prompt_padding (math $g_prompt_available - $g_prompt_count)
    end

    # Print right prompt
    set g_prompt_mode_count false
    for i in $c_prompt_right_modules
        eval __prompt_$i
    end

    # Print the prompt built so far
    echo -e $g_prompt_string

    # New line
    # --------
    __prompt_initialize

    for i in $c_prompt_newline_modules
        eval __prompt_$i
    end

    echo -e $g_prompt_string
end
