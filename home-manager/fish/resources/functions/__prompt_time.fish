function __prompt_time --description="Display the current time!"

    # [boolean] c_date_show         => show date
    # [boolean] c_time_show         => show time
    # [string ] c_time_prefix       => module prefix
    # [string ] c_time_suffix       => module suffix
    # [color  ] c_date_time_color   => date/time color
    # [color  ] c_date_time_bgcolor => date/time background color
    __prompt_setconfig c_date_show         false
    __prompt_setconfig c_time_show         false
    __prompt_setconfig c_time_prefix       $c_prompt_default_prefix
    __prompt_setconfig c_time_suffix       $c_prompt_default_suffix
    __prompt_setconfig c_date_time_color   $c_prompt_default_color
    __prompt_setconfig c_date_time_bgcolor $c_prompt_default_bgcolor

    # --------------------------------------------------------------------------

    if [ $c_date_show = false -a $c_time_show = false ]
        return
    end

    set --local date_time_str ""

    if [ $c_date_show = true ]
        set date_time_str (date '+%d-%m-%Y')
    end

    if [ $c_date_show = true -a $c_time_show = true ]
        set date_time_str "$date_time_str "
    end

    if [ $c_time_show = true ]
        set date_time_str "$date_time_str"(date '+%H:%M:%S')
    end

    __prompt_print \
        $c_date_time_color \
        $c_date_time_bgcolor \
        $c_time_prefix \
        $date_time_str \
        $c_time_suffix
end
