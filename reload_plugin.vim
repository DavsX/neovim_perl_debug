if exists('g:neovim_perl_debug_job')
    call jobstop(g:neovim_perl_debug_job)
    unlet g:neovim_perl_debug_job
endif
