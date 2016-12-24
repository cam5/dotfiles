source ~/.vim/autoload/pathogen.vim
source ~/.vimrc

execute pathogen#infect('~/.vim/bundle/{}')

execute pathogen#infect('~/.config/nvim/bundle/{}')

" Reload this config, not just vimrc.
nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" Signs
highlight clear SpellBad
highlight clear SpellCap
hi SyntasticStyleErrorSign ctermfg=95 ctermbg=none
hi SyntasticStyleWarningSign ctermfg=239 ctermbg=none
hi SyntasticErrorSign ctermfg=95 ctermbg=none
hi SyntasticWarningSign ctermfg=239 ctermbg=none
hi SpellBad ctermbg=237
hi SpellCap ctermbg=237

" GitGutter
hi DiffAdd ctermbg=64

" Tab Colors
hi Tabline ctermfg=243
hi TablineSel ctermfg=254


" Deoplete!
nnoremap <leader>d :call deoplete#toggle()<CR>
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 2

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})

let g:deoplete#omni#functions.php = 'phpcomplete#CompletePHP'
let g:deoplete#omni_patterns.php  =
    \ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

if filereadable($PWD.'/src/tsconfig.json')
    autocmd! BufWritePost * Neomake

    let g:neomake_typescript_tslint_maker = {
        \ 'args': [
            \'%:p',
            \'--format verbose',
            \'--type-check',
            \'--project='.$PWD.'/src/tsconfig.json',
            \'--exclude="**/node_modules/**"'
            \],
        \ 'errorformat': '%E%f[%l\, %c]: %m'
        \ }

    let g:neomake_typescript_enabled_makers = ['tslint']
endif
