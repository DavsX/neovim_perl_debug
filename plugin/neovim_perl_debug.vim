if exists('g:neovim_perl_debug_loaded')
    " finish
endif
let g:neovim_perl_debug_loaded = 1
let g:neovim_perl_debug_buffer = []

if !has('nvim')
	echom "This plugin requires neovim"
	finish
endif

function! s:JobHandler(job_id, data, event)
	if a:event == 'stdout'
		for l:line in a:data
			let l:line = substitute(l:line, '\r', '', 'g')
			if l:line == '' || l:line == ' '
				continue
			endif
			call add(g:neovim_perl_debug_buffer, l:line)
			if l:line =~# '\v^\s*DB\<'
				echon "END ".l:line
			endif
		endfor
	elseif a:event == 'stderr'
	else
		call jobstop(a:job_id)
	endif
endfunction

let s:job_options = {
\ 'on_stdout': function('s:JobHandler'),
\ 'on_stderr': function('s:JobHandler'),
\ 'on_exit': function('s:JobHandler'),
\ 'pty': 1,
\ 'TERM': ''
\ }

let g:neovim_perl_debug_job = jobstart(['perl', '-d', '/tmp/test.pl'], s:job_options)
