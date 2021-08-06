function __prompt_host -d "Display the current hostname if connected over SSH"

    # [boolean] c_host_show        => show hostname (true, false, needed)
    # [string ] c_host_prefix      => module prefix
    # [string ] c_host_suffix      => module suffix
    # [color  ] c_host_color       => hostname color
    # [color  ] c_host_bgcolor     => hostname background color
    # [color  ] c_host_color_ssh   => SSH hostname color
    # [color  ] c_host_bgcolor_ssh => SSH hostname background color
    __prompt_setconfig c_host_show        false
    __prompt_setconfig c_host_prefix      $c_prompt_default_prefix
    __prompt_setconfig c_host_suffix      $c_prompt_default_suffix
    __prompt_setconfig c_host_color       $c_prompt_default_color
    __prompt_setconfig c_host_bgcolor     $c_prompt_default_bgcolor
    __prompt_setconfig c_host_color_ssh   $c_prompt_default_color
    __prompt_setconfig c_host_bgcolor_ssh $c_prompt_default_bgcolor

    # --------------------------------------------------------------------------

    if [ $c_host_show = false ]
        return
    end

    set --local is_ssh (__prompt_util_isset SSH_CONNECTION)

    if [ $c_host_show = true -o \( $is_ssh = true -a $c_host_show = needed \) ]
       # Determination of what color should be used
       set -l host_color
       set -l host_bgcolor

       if [ $is_ssh = true ]
           set host_color    $c_host_color_ssh
           set host_bgcolor  $c_host_bgcolor_ssh
       else
           set host_color    $c_host_color
           set host_bgcolor  $c_host_bgcolor
       end

       __prompt_print \
           $host_color \
           $host_bgcolor \
           $c_host_prefix \
           (hostname) \
           $c_host_suffix
    end
end
