command! CscopeInit call cscope#init()
command! CscopeUpdate call cscope#update()
command! CscopeRebuild call cscope#rebuild()

" Initialize cscope
:function! cscope#init()
    if !exists('g:cscope_dirs') || empty(g:cscope_dirs)
        return
    endif

    if !exists('g:cscope_dir') || empty(g:cscope_dir)
        return
    endif

    " For each directory...
    let l:dirs = split(g:cscope_dirs, ' ')

    for l:dir in l:dirs
        " Check if directory exists
        if !isdirectory(l:dir)
            continue
        endif

        let l:path = g:cscope_dir . '/' . md5#md5(l:dir)
        let l:db = l:path . '/cscope.out'

        if !filereadable(l:db)
            continue
        endif

        " Add database to csope
        execute 'silent cscope add ' . l:db

        " Display
        echom 'Added database ' . l:db . ' for dir ' . l:dir
    endfor

    " Reset cscope
    execute 'silent cscope reset'
:endfunction

" Run cscope on files
:function! cscope#update()
    if !exists('g:cscope_dirs') || empty(g:cscope_dirs)
        return
    endif

    if !exists('g:cscope_dir') || empty(g:cscope_dir)
        return
    endif

    " For each directory...
    let l:dirs = split(g:cscope_dirs, ' ')

    for l:dir in l:dirs
        " Check if directory exists
        if !isdirectory(l:dir)
            continue
        endif

        let l:path = g:cscope_dir . '/' . md5#md5(l:dir)
        let l:db = l:path . '/cscope.out'
        let l:files = l:path . '/cscope.files'

        " Rebuild indexes
        execute 'silent ! cscope -b -q -f ' . l:db . ' -i ' . l:files

        " Display
        echom 'Rebuild database ' . l:db . ' for directory ' . l:dir
    endfor

    " Reset database
    cscope reset
:endfunction

" Rebuild files list and run cscope
:function! cscope#rebuild()
    if !exists('g:cscope_dirs') || empty(g:cscope_dirs)
        return
    endif

    if !exists('g:cscope_dir') || empty(g:cscope_dir)
        return
    endif

    " Prepare
    let l:opts = " -iname '*.[ch]'"
        \ . " -o -name '*.cpp'"
        \ . " -o -name '*.cc'"
        \ . " -o -name '*.hpp'"
        \ . " -o -name '*.py'"
        \ . " -o -name '*.proto'"

    " Close all cscope database first
    cscope kill -1

    " For each directory...
    let l:dirs = split(g:cscope_dirs, ' ')

    for l:dir in l:dirs
        " Check if directory exists
        if !isdirectory(l:dir)
            continue
        endif

        let l:path = g:cscope_dir . '/' . md5#md5(l:dir)
        let l:db = l:path . '/cscope.out'
        let l:files = l:path . '/cscope.files'
        let l:directory = l:path . '/directory'

        " Reset folder (remove first if exists)
        if isdirectory(l:path)
            execute 'silent ! rm -rf ' . l:path
        endif

        execute 'silent ! mkdir -p ' . l:path
        execute 'silent ! echo ' . l:dir . ' > ' . l:directory

        " Create file list in this directory
        execute 'silent ! find ' . l:dir
            \ . ' -type f' . l:opts
            \ . ' > ' . l:files

        " Build indexes
        execute 'silent ! cscope -b -q -f ' . l:db . ' -i ' . l:files

        " Add database to cscope
        execute 'silent :cscope add ' . l:db

        " Display
        echom 'Added database ' . l:db . ' for directory ' . l:dir
    endfor
:endfunction

