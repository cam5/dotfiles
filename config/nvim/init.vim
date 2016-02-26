source ~/.vim/autoload/pathogen.vim
" source ~/.vim/autoload/airline/themes/sierra.vim
source ~/.vimrc

execute pathogen#infect('~/.vim/bundle/{}')

nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_symbols.linenr = ''
" let g:airline_symbols.branch = ''
let g:airline_theme='zenburn'

colorscheme sierra
syntax enable                  " Syntax-highlighting
filetype plugin indent on
