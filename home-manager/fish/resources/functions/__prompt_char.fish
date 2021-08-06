function __prompt_char -d "Display the prompt character"

    # [boolean] c_char_show          => show character
    # [string ] c_char_prefix        => module prefix
    # [string ] c_char_suffix        => module suffix
    # [string ] c_char_symbol        => character to show
    # [string ] c_char_symbol_root   => character to show when root
    # [color  ] c_char_color_success => last command succeeded color
    # [color  ] c_char_color_failure => last command failed color
    # [color  ] c_char_bgcolor       => character background color
    __prompt_setconfig c_char_show          true
    __prompt_setconfig c_char_prefix        $c_prompt_default_prefix
    __prompt_setconfig c_char_suffix        $c_prompt_default_suffix
    __prompt_setconfig c_char_symbol        "➜"
    __prompt_setconfig c_char_symbol_root   "#"
    __prompt_setconfig c_char_color_success $c_prompt_default_color
    __prompt_setconfig c_char_color_failure $c_prompt_default_color
    __prompt_setconfig c_char_bgcolor       $c_prompt_default_bgcolor

    # --------------------------------------------------------------------------

    set --local color
    set --local char

    if [ $g_exit_code -eq 0 ]
        set color $c_char_color_success
    else
        set color $c_char_color_failure
    end

    if [ "$UID" = "0" ]
        set char $c_char_symbol_root
    else
        set char $c_char_symbol
    end

    __prompt_print \
        $color \
        $c_char_bgcolor \
        $c_char_prefix \
        $char \
        $c_char_suffix
end
