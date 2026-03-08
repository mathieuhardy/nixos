function global_init
    # Abbreviations
    abbr fr       'find . -name "*.xml" -exec sed -i "s#toto#tata#g" "{}" \;'
    abbr fs       'find . -name "*.xml" -exec egrep -niH --color "toto" "{}" \;'

    abbr j        'jobs'
    abbr pg       'pgrep -a'

    abbr c        'clear'
    abbr e        'exit'

    abbr g        'rg --smart-case --no-heading --sort path'
    abbr grep     'egrep'

    abbr l        'lsd --group-directories-first -h -l'
    abbr ll       'lsd --group-directories-first -h -l'
    abbr m        'lsd --group-directories-first -h -l'
    abbr ù        'lsd --group-directories-first -h -l'
    abbr la       'lsd --group-directories-first -h -l -a'

    abbr mkdir    'mkdir -p'

    abbr t        'tail -f'
    abbr make     'make -j4'
    abbr h        'history'

    abbr tree     'lsd --group-directories-first --git --tree -h -l'

    abbr untar    'tar xvf'

    abbr ee       'nvim'
    abbr see      'sudo -E nvim'

    abbr rm       'trash put'

    abbr todo     'rg --smart-case --no-heading --sort path TODO'

    abbr reboot   'echo "No way !"'
    abbr poweroff 'echo "No way !"'
end
