function Check_if_perl()
    "bail if  the filetype was already decided.
    if did_filetype()
        return
    endif

    "Check the shabang
    if getline(1) =~ '^#!.*perl'
        setf perl
        finish
    endif

    "as a last ditch effort such as a perl script within a batch file.
    " TODO: Should i do this or simply rely on....
    " # vim: set filetype=perl :
    let i = 1
    while i <= 12
        if getline(i) =~ '-\*- perl -\*-'
            setf perl
            finish
        endif
        let i += 1
    endwhile
endfunction

au! BufRead,BufNewFile * call Check_if_perl()
