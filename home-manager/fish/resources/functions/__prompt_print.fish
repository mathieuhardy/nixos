function __prompt_print -a color bgcolor prefix content suffix -d "Print a prompt item"

    if [ $g_prompt_available -lt 0 ]
        return
    end

    if [ $g_prompt_mode_count = true ]
        set g_prompt_count (math $g_prompt_count + (string length -- "$prefix"))
        set g_prompt_count (math $g_prompt_count + (string length -- "$content"))
        set g_prompt_count (math $g_prompt_count + (string length -- "$suffix"))
        return
    end

    # Foreground and background colors
    if [ "$color" != "" -a "$bgcolor" != "" ]
        set g_prompt_string "$g_prompt_string"(set_color --bold "$color" --background "$bgcolor")
    else if [ "$color" != "" ]
        set g_prompt_string "$g_prompt_string"(set_color --bold "$color")
    end

    # Prefix
    if [ $c_prompt_prefixes_show = true ]
        set g_prompt_string "$g_prompt_string$prefix"
        set g_prompt_available (math $g_prompt_available - (string length -- "$prefix"))
    end

    # Content
    set g_prompt_string "$g_prompt_string$content"
    set g_prompt_available (math $g_prompt_available - (string length -- "$content"))

    # Suffix
    if [ $c_prompt_suffixes_show = true ]
        set g_prompt_string "$g_prompt_string$suffix"
        set g_prompt_available (math $g_prompt_available - (string length -- "$suffix"))
    end

    # Reset color
    set g_prompt_string "$g_prompt_string"(set_color normal)

    # Set prompt has started
    if [ "$content" != "" -a "$content" != "\n" ]
        set g_prompt_start false
    end
end

function __prompt_padding -a count
    if [ $count = 0 ]
       return
    end

    set --local padding (printf "%"$count"s" "")

    set g_prompt_string "$g_prompt_string$padding"
    set g_prompt_available (math $g_prompt_available - $count)
end
