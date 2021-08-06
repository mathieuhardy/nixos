function __prompt_exec_time -d "Display the execution time of the last command"

    __prompt_setconfig c_exec_time_show        false
    __prompt_setconfig c_exec_time_prefix      $c_prompt_default_prefix
    __prompt_setconfig c_exec_time_suffix      $c_prompt_default_suffix
    __prompt_setconfig c_exec_time_color       $c_prompt_default_color
    __prompt_setconfig c_exec_time_bgcolor     $c_prompt_default_bgcolor
    __prompt_setconfig c_exec_time_min_seconds 5

    # --------------------------------------------------------------------------

    if [ $c_exec_time_show = false ]
        return
    end

    # Allow for compatibility between fish 2.7 and 3.0
    set --local duration "$CMD_DURATION$cmd_duration"

    if test -n "$duration" -a "$duration" -gt (math "$c_exec_time_min_seconds * 1000")
       set --local duration_str (echo $duration | __prompt_util_human_time)

       __prompt_print \
           $c_exec_time_color \
           $c_exec_time_bgcolor \
           $c_exec_time_prefix \
           $duration_str \
           $c_exec_time_suffix
    end
end
