function __prompt_exit_code -d "Shows the exit code from the previous command."

    # [boolean] c_exit_code_show    => show status of last command
    # [string ] c_jobs_prefix       => module prefix
    # [string ] c_jobs_suffix       => module suffix
    # [color  ] c_exit_code_color   => status color
    # [color  ] c_exit_code_bgcolor => status background color
    # [string ] c_exit_code_symbol  => string to display
    __prompt_setconfig c_exit_code_show    false
    __prompt_setconfig c_exit_code_prefix  $c_prompt_default_prefix
    __prompt_setconfig c_exit_code_suffix  $c_prompt_default_suffix
    __prompt_setconfig c_exit_code_color   $c_prompt_default_color
    __prompt_setconfig c_exit_code_bgcolor $c_prompt_default_bgcolor
    __prompt_setconfig c_exit_code_symbol  "✘"

    # --------------------------------------------------------------------------

    if [ $c_exit_code_show = false -o $g_exit_code -eq 0 ]
        return
    end

    __prompt_print \
        $c_exit_code_color \
        $c_exit_code_bgcolor \
        $c_exit_code_prefix \
        "$c_exit_code_symbol$g_exit_code" \
        $c_exit_code_suffix
end
