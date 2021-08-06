function __prompt_user -d "Display the username"

    # --------------------------------------------------------------------------
    # | c_user_show   | show username on local | show username on remote |
    # |---------------+------------------------+-------------------------|
    # | false         | never                  | never                   |
    # | always        | always                 | always                  |
    # | true          | if needed              | always                  |
    # | needed        | if needed              | if needed               |
    # --------------------------------------------------------------------------

    # [boolean] c_user_show         => show user (false, true, needed, always)
    # [string ] c_user_prefix       => module prefix
    # [string ] c_user_suffix       => module suffix
    # [color  ] c_user_color        => user color
    # [color  ] c_user_bgcolor      => user background color
    # [color  ] c_user_color_root   => root user color
    # [color  ] c_user_bgcolor_root => root user background color
    __prompt_setconfig c_user_show         false
    __prompt_setconfig c_user_prefix       $c_prompt_default_prefix
    __prompt_setconfig c_user_suffix       $c_prompt_default_suffix
    __prompt_setconfig c_user_color        $c_prompt_default_color
    __prompt_setconfig c_user_bgcolor      $c_prompt_default_bgcolor
    __prompt_setconfig c_user_color_root   $c_prompt_default_color
    __prompt_setconfig c_user_bgcolor_root $c_prompt_default_bgcolor

    # --------------------------------------------------------------------------

    if [ $c_user_show = false ]
        return
    end

    if [ "$c_user_show" = "always" -o "$LOGNAME" != "$USER" -o "$UID" = "0" -o \( "$c_user_show" = "true" -a -n "$SSH_CONNECTION" \) ]

       set --local user_color
       set --local user_bgcolor

       if [ "$USER" = "root" ]
           set user_color    $c_user_color_root
           set user_bgcolor  $c_user_bgcolor_root
       else
           set user_color    $c_user_color
           set user_bgcolor  $c_user_bgcolor
       end

       __prompt_print \
           $user_color \
           $user_bgcolor \
           $c_user_prefix \
           $USER \
           $c_user_suffix
    end
end
