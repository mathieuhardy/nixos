function fish_add_user_path
    if ! set --query fish_user_paths
        set --universal fish_user_paths ''
    end

    if ! string match -q -- $argv $fish_user_paths
        set --append fish_user_paths $argv
    end
end
