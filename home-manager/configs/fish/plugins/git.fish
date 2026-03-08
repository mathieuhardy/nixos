function git_init
    # Abbreviations
    abbr clone      'git clone'

    abbr clean      'git clean -fd'

    abbr fetch      'git fetch'
    abbr pull       'git pull --rebase --tags --prune'
    abbr push       'git push'
    abbr pusho      'git push -u origin $(git rev-parse --abbrev-ref HEAD)'
    abbr please     'git push --force-with-lease'
    abbr pick       'git cherry-pick'

    abbr ci          'git commit'
    abbr amend       'git commit --amend'
    abbr co          'git checkout'
    abbr sw          'git switch'
    abbr hard        'git reset --hard'
    abbr rebase      'git rebase'
    abbr abort       'git rebase --abort'
    abbr continue    'git rebase --continue'

    abbr merge       'git merge'
    abbr mergetool   'git mergetool -t meld'

    abbr st          'git status --short'
    abbr br          'git branch'
    abbr di          'git difftool -y -t meld'
    abbr gld         'git log --oneline --decorate -20'
    abbr glg         ''\
'git log'\
" --pretty=format:'%C(yellow)[%H]%Creset %C(green)[%ai] %C(blue)[%an] %C(red) %d%Creset"\
" - %s' --abbrev-commit -20"
    abbr gb          'git-branch-checker'

    abbr pop         'git stash pop'
    abbr stash       'git stash'

    abbr submodule   'git submodule update --init --recursive'

    abbr fixup       'git commit --fixup'
    abbr squash      'git rebase -i --autosquash'

    abbr gg          'gitg --all&'
end
