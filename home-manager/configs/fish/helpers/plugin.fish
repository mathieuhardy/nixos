function fish_plugin_register --argument-names path name
    switch $name
    case "*disabled"
        return
    end

    set --local name $(string replace '.fish' '' $name)
    set --local file "$path/$name.fish"

    source $file

    eval (string join '' $name '_init')
end
