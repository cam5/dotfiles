source ~/.vim/autoload/pathogen.vim
source ~/.vimrc

execute pathogen#infect('~/.vim/bundle/{}')

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
hi SpellBad ctermbg=237
hi SpellCap ctermbg=237

hi Tabline ctermfg=243
hi TablineSel ctermfg=254

