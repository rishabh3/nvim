" Jump to last line in worked file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif


" quickfix window

noremap <F9>  :execute "vertical botright copen \| vertical resize 60"<cr>
noremap <F10> :execute "copen \| resize 40"<cr>

noremap <F8> :execute "cclose"<cr>
