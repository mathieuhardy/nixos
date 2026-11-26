function fish_add_user_path
    if ! set --query fish_user_paths
        set --universal fish_user_paths ''
    end

    if ! string match -q -- $argv $fish_user_paths
        set --append fish_user_paths $argv
    end
end

function file_to_env --argument-names path variable_name
    if not test -f $path
        return
    end

    set -l value (string trim (cat $path))

    if test -n "$value"
        set -gx -- $variable_name $value
    end
end
