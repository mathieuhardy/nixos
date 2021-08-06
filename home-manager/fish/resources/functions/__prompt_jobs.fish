function __prompt_jobs -d "Show icon, if there's a working jobs in the background."

    # [boolean] c_jobs_show      => show background jobs
    # [string ] c_jobs_prefix    => module prefix
    # [string ] c_jobs_suffix    => module suffix
    # [color  ] c_jobs_color     => jobs color
    # [color  ] c_jobs_bgcolor   => jobs background color
    # [string ] c_jobs_symbol    => string to display
    # [string ] c_jobs_threshold => threashold for display
    __prompt_setconfig c_jobs_show      false
    __prompt_setconfig c_jobs_prefix    $c_prompt_default_prefix
    __prompt_setconfig c_jobs_suffix    $c_prompt_default_suffix
    __prompt_setconfig c_jobs_color     $c_prompt_default_color
    __prompt_setconfig c_jobs_bgcolor   $c_prompt_default_bgcolor
    __prompt_setconfig c_jobs_symbol    "⬢"
    __prompt_setconfig c_jobs_threshold 1

    # --------------------------------------------------------------------------

    if [ $c_jobs_show = false ]
        return
    end

    set --local jobs_amount (jobs | wc -l | xargs)

    if [ $jobs_amount -eq 0 ]
        return
    end

    if [ $jobs_amount -le $c_jobs_threshold ]
        set jobs_amount ''
    end

    __prompt_print \
        $c_jobs_color \
        $c_jobs_bgcolor \
        $c_jobs_prefix \
        "$c_jobs_symbol $jobs_amount" \
        $c_jobs_suffix
end
