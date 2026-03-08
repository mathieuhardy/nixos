function export_ai_api_keys --argument-names path variable_name
    if not test -f $path
        return
    end

    set -l value (string trim (cat $path))

    if test -n "$value"
        set -gx -- $variable_name $value
    end
end
