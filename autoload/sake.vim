if !exists('g:vim_sake_loaded') || &cp
    let g:vim_sake_loaded = 1
else
    finish
endif

func! sake#Complete(arglead, cmdline, cursorpos)
    let output = split(system('sake'), '\n')
    let tasks = []

    for line in output[2:-1]
        try
            let task = split(line, ' ')[1]
            call add(tasks, task)
        catch
        endtry
    endfor

    let bits = split(a:cmdline, ' ')
    if len(bits) > 1
        let word = bits[1]
        return filter(tasks, 'v:val =~ "'.word.'"')
    else
        return tasks
    endif
endf

func! sake#Preview(task)
    pclose
    pedit sake-tasks
    wincmd p
    silent! exe '0r!sake '.a:task
    norm Gdd
    setlocal ft=coffee
    map <buffer> q :pclose<cr>
    setl buftype=nofile
    setl bufhidden=delete
    setl nobuflisted
endf

func! sake#Task(bang, ...)
    if a:0 == 0
        call sake#Preview('')
    else
        exe '!sake '.join(a:000, ' ')
    endif
endf
