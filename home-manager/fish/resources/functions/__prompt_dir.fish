function __prompt_dir -d "Display the current truncated directory"

    # [boolean] c_dir_show          => show dir
    # [string ] c_dir_prefix        => module prefix
    # [string ] c_dir_suffix        => module suffix
    # [color  ] c_dir_color         => directory path color
    # [color  ] c_dir_bgcolor       => directory path background color
    # [boolean] c_dir_truncate_repo => relative path for git (sub)folder
    # [boolean] c_dir_truncate_home => relative path for home folder
    # [boolean] c_dir_lock_show     => show lock icon if read-only
    # [string ] c_dir_lock_symbol   => lock icon character
    # [color  ] c_dir_lock_color    => lock icon color
    __prompt_setconfig c_dir_show          false
    __prompt_setconfig c_dir_prefix        $c_prompt_default_prefix
    __prompt_setconfig c_dir_suffix        $c_prompt_default_suffix
    __prompt_setconfig c_dir_color         $c_prompt_default_color
    __prompt_setconfig c_dir_bgcolor       $c_prompt_default_bgcolor
    __prompt_setconfig c_dir_truncate_repo false
    __prompt_setconfig c_dir_truncate_home false

    # Write Permissions lock symbol
    __prompt_setconfig c_dir_lock_show     true
    __prompt_setconfig c_dir_lock_symbol   "󰌾"
    __prompt_setconfig c_dir_lock_color    "red"

    # --------------------------------------------------------------------------

    if [ $c_dir_show = false ]
        return
    end

    set --local dir
    set --local lock_str
    set --local git_root (command git rev-parse --show-toplevel 2>/dev/null)

    if [ $c_dir_truncate_repo = true -a -n "$git_root" ]
        set --local pwd_path (pwd -P 2>/dev/null; or pwd)
        set dir (string replace $git_root (basename $git_root) $pwd_path)
    else if [ $c_dir_truncate_home = true ]
        set --local realhome ~
        set dir (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)
    else
        set dir $PWD
    end

    if [ $c_dir_lock_show = true -a ! -w . ]
        set lock_str (set_color $c_dir_lock_color)"$c_dir_lock_symbol"(set_color normal)
    end

    if [ $g_prompt_start = true ]
        set -g c_dir_prefix ""
    end

    __prompt_print \
        $c_dir_color \
        $c_dir_bgcolor \
        $c_dir_prefix \
        "$dir$lock_str" \
        $c_dir_suffix
end
