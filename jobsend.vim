if exists('g:neovim_perl_debug_job')
    call jobsend(g:neovim_perl_debug_job, "cs\n")
endif
