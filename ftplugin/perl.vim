noremap <silent> <buffer> <leader>cv :call Coverage()<CR>
noremap <silent> <buffer> <leader>t :call ReTest()<CR>

function! GetCoveredFiles(cmd, filename, insub)
    let l:cmd = a:cmd . ' covering --source_file="'. a:filename .'"'
    let l:subname = ''
    if !g:cfi_disable
        let l:subname = cfi#get_func_name()
    endif
    if l:subname != '' && a:insub
        let l:cmd = l:cmd . ' --sub="' . l:subname . '"'
    endif
    return l:cmd
endfunction

function! ReTest()
    silent !clear
    let l:filename = bufname('%')
    if match(l:filename, '\.t$') > -1
        " If we are in a test file, just run that testfile again?
        let l:files = filename
    else
        let l:files = system(GetCoveredFiles('covered', l:filename, 1) . ' | tr "\n" " " ')
        if l:files == " "
            " No files found, lets try nosub?
            let l:files = system(GetCoveredFiles('covered', l:filename, 0) . ' | tr "\n" " "')
        endif
    endif
    let l:cmd = 'prove -mvl --norc ' . files
    let l:bufnr = bufwinnr("__Prove_Output__")
    if l:bufnr != -1
        exec l:bufnr . "wincmd w"
    else
        vsplit __Prove_Output__
        setlocal filetype=tap
        setlocal buftype=nofile
    endif
    setlocal modifiable
    normal! ggdG
    let lines = ["# Please wait for prove to run...",
                \"# Files:"]
    call setline(2, lines + map(split(l:files, "\v\s"), '"# * " . v:val'))
    redraw

    if files != " "
        let l:proveout = system(l:cmd)
    else
        let l:proveout = "No files selected, not running prove"
    endif
    normal! ggdG
    call append(0, split(l:proveout, '\v\n'))
    setlocal nomodifiable
    wincmd p
endfunction

function! Coverage()
    silent !clear
    if !filereadable('covered/covered-0.01.db')
        echo "No coverage available.."
        return
    endif
    echo "Getting coverage.."
    let l:filename = bufname('%')
    let l:cmd = 'covered'
    if match(l:filename, '\.t$') > -1
        let l:cmd = l:cmd . ' by --test_file="'. l:filename .'"'
    else
        let l:cmd = GetCoveredFiles(l:cmd, l:filename, 1)
    end
    let l:cmd = l:cmd . "| awk 'BEGIN { OFS=\":\" } { print $1, 1, $1; }'"
    let l:output = system(cmd)
    " Lets make a location list!
    if l:output != ":1:\n"
        lgetexpr l:output
        lopen
    else
        echom "No coverage found!"
    endif
endfunction

