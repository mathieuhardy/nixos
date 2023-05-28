function __prompt_git -d "Display the git branch and status"

    # [boolean] c_git_branch_show      => show Git branch
    # [boolean] c_git_status_show      => show Git status
    # [string ] c_git_status_separator => separator between Git status items
    # [color  ] c_git_color            => Git default color
    # [color  ] c_git_bgcolor          => Git default background color
    # [list   ] c_git_prompt_order     => Git items order
    #                                       - untracked
    #                                       - modified
    #                                       - added
    #                                       - renamed
    #                                       - deleted
    #                                       - stashed
    #                                       - diverged
    #                                       - ahead
    #                                       - behind
    __prompt_setconfig c_git_branch_show      false
    __prompt_setconfig c_git_status_show      false
    __prompt_setconfig c_git_status_separator " "
    __prompt_setconfig c_git_prefix           $c_prompt_default_prefix
    __prompt_setconfig c_git_suffix           $c_prompt_default_suffix
    __prompt_setconfig c_git_color            $c_prompt_default_color
    __prompt_setconfig c_git_bgcolor          $c_prompt_default_bgcolor
    __prompt_setconfig c_git_prompt_order     untracked modified added renamed deleted stashed conflict diverged ahead behind

    # [string ] c_git_status_untracked => character for untracked file
    # [string ] c_git_status_modified  => character for modified file
    # [string ] c_git_status_added     => character for added file
    # [string ] c_git_status_renamed   => character for renamed file
    # [string ] c_git_status_deleted   => character for deleted file
    # [string ] c_git_status_stashed   => character for stash presence
    # [string ] c_git_status_diverged  => character for diverged status
    # [string ] c_git_status_ahead     => character for ahead status
    # [string ] c_git_status_behind    => character for behind status
    # [string ] c_git_status_conflict  => character for conflict status
    __prompt_setconfig c_git_status_untracked "?"
    __prompt_setconfig c_git_status_modified  "~"
    __prompt_setconfig c_git_status_added     "✚"
    __prompt_setconfig c_git_status_renamed   "»"
    __prompt_setconfig c_git_status_deleted   "✘"
    __prompt_setconfig c_git_status_stashed   "𝌆 "
    __prompt_setconfig c_git_status_diverged  "⎇ "
    __prompt_setconfig c_git_status_ahead     "⬆"
    __prompt_setconfig c_git_status_behind    "⬇"
    __prompt_setconfig c_git_status_conflict  "⚑"

    # [color  ] c_git_status_color_untracked => color for untracked file
    # [color  ] c_git_status_color_modified  => color for modified file
    # [color  ] c_git_status_color_added     => color for added file
    # [color  ] c_git_status_color_renamed   => color for renamed file
    # [color  ] c_git_status_color_deleted   => color for deleted file
    # [color  ] c_git_status_color_stashed   => color for statsh presence
    # [color  ] c_git_status_color_diverged  => color for diverged status
    # [color  ] c_git_status_color_ahead     => color for ahead status
    # [color  ] c_git_status_color_behind    => color for behind status
    __prompt_setconfig c_git_status_color_untracked "white"
    __prompt_setconfig c_git_status_color_modified  "yellow"
    __prompt_setconfig c_git_status_color_added     "purple"
    __prompt_setconfig c_git_status_color_renamed   "green"
    __prompt_setconfig c_git_status_color_deleted   "red"
    __prompt_setconfig c_git_status_color_stashed   "blue"
    __prompt_setconfig c_git_status_color_diverged  "red"
    __prompt_setconfig c_git_status_color_ahead     "green"
    __prompt_setconfig c_git_status_color_behind    "red"
    __prompt_setconfig c_git_status_color_conflict  "red"

    # [boolean] c_git_status_show_count_untracked => show count of untracked files
    # [boolean] c_git_status_show_count_modified  => show count of modified files
    # [boolean] c_git_status_show_count_added     => show count of added files
    # [boolean] c_git_status_show_count_renamed   => show count of renamed files
    # [boolean] c_git_status_show_count_deleted   => show count of deleted files
    # [boolean] c_git_status_show_count_stashed   => show count of stashes
    # [boolean] c_git_status_show_count_ahead     => show count of commits ahead
    # [boolean] c_git_status_show_count_behind    => show count of commits behind
    # [boolean] c_git_status_show_count_conflict  => show count of conflict files
    __prompt_setconfig c_git_status_show_count_untracked false
    __prompt_setconfig c_git_status_show_count_modified  false
    __prompt_setconfig c_git_status_show_count_added     false
    __prompt_setconfig c_git_status_show_count_renamed   false
    __prompt_setconfig c_git_status_show_count_deleted   false
    __prompt_setconfig c_git_status_show_count_stashed   true
    __prompt_setconfig c_git_status_show_count_diverged  false
    __prompt_setconfig c_git_status_show_count_ahead     true
    __prompt_setconfig c_git_status_show_count_behind    true
    __prompt_setconfig c_git_status_show_count_conflict  false

    # ------------------------------------------------------------------------------

    if [ $c_git_branch_show = false -a $c_git_status_show = false ]
        return
    end

    # Git branch
    set -l git_branch (command git describe --exact-match HEAD 2>/dev/null; or git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -z "$git_branch" ]
        return
    end

    # Display (without suffix)
    __prompt_print \
        $c_git_color \
        $c_git_bgcolor \
        $c_git_prefix \
        $git_branch \
        ""

    # Git status
    set --local status_str      (command git status --porcelain 2>/dev/null)
    set --local count_untracked 0
    set --local count_modified  0
    set --local count_added     0
    set --local count_renamed   0
    set --local count_deleted   0
    set --local count_stashed   (command git rev-list --walk-reflogs --count refs/stash 2>/dev/null)
    set --local count_diverged  0
    set --local count_ahead     (command git log --oneline @\{u\}.. 2>/dev/null | wc -l | sed 's/^ *//')
    set --local count_behind    (command git log --oneline ..@\{u\} 2>/dev/null | wc -l | sed 's/^ *//')
    set --local count_conflict  0

    if [ $count_ahead -gt 0 -a $count_behind -gt 0 ]
        set count_diverged 1
    end

    if [ -n "$status_str" ]
        set count_untracked   (string match --all --regex "^\?\?" $status_str | wc -l | sed 's/^ *//')
        set count_modified    (string match --all --regex "^[ M]M.*" $status_str | wc -l | sed 's/^ *//')
        set count_added       (string match --all --regex "^A.*" $status_str | wc -l | sed 's/^ *//')
        set count_renamed     (string match --all --regex "^R.*" $status_str | wc -l | sed 's/^ *//')
        set count_deleted     (string match --all --regex "^D.*" $status_str | wc -l | sed 's/^ *//')                        
        set count_conflict    (string match --all --regex "^U.*" $status_str | wc -l | sed 's/^ *//')
    end

    for i in $c_git_prompt_order
        set --local count count_$i

        if [ "$$count" = "0" -o "$$count" = "" ]
            continue
        end

        set --local status_symbol c_git_status_$i
        set --local status_color  c_git_status_color_$i
        set --local show_count    c_git_status_show_count_$i

        # Display
        if [ "$$show_count" = "true" ]
            __prompt_print \
                $$status_color \
                $c_git_bgcolor \
                $c_git_status_separator \
                "$$status_symbol$$count" \
                ""
        else
            __prompt_print \
                $$status_color \
                $c_git_bgcolor \
                $c_git_status_separator \
                "$$status_symbol" \
                ""
        end
    end

    # Display (suffix only)
    __prompt_print \
        $c_git_color \
        $c_git_bgcolor \
        "" \
        "" \
        $c_git_suffix
end
