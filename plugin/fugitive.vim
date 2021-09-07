" This vimscript contains all mapping for fugitive plugins
" Show commits for every source line
nnoremap <Leader>gb :Git blame<CR> 
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit -v -q<CR>
nnoremap <Leader>gt :Git commit -v -q %:p<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Gclog<CR>:bot copen<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :GMove<Space>
nnoremap <Leader>gbr :Git branch<Space>
nnoremap <Leader>gco :Git checkout<Space>
nnoremap <Leader>gf  :Git fetch<CR>
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>
