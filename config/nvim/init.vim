source ~/.vim/autoload/pathogen.vim
source ~/.vimrc

execute pathogen#infect('~/.vim/bundle/{}')

execute pathogen#infect('~/.config/nvim/bundle/{}')

" set encoding=utf-8
set fileencoding=utf-8

nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.linenr = ''
let g:airline_theme='sierra'

colorscheme sierra
syntax enable                  " Syntax-highlighting
filetype plugin indent on

highlight clear SpellBad
highlight clear SpellCap

hi SyntasticStyleErrorSign ctermfg=95 ctermbg=none
hi SyntasticStyleWarningSign ctermfg=239 ctermbg=none
hi SyntasticErrorSign ctermfg=95 ctermbg=none
hi SyntasticWarningSign ctermfg=239 ctermbg=none
hi SpellBad ctermbg=237
hi SpellCap ctermbg=237

hi DiffAdd ctermbg=64

hi Tabline ctermfg=243
hi TablineSel ctermfg=254


" Deoplete!
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 3

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni#functions.php = 'phpcomplete#CompletePHP'
let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})
let g:deoplete#omni_patterns.php =
    \ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

