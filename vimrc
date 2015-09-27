" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Include Plugins
" ▸ ack.vim/
" ▸ ctrlp.vim/
" ▸ emmet-vim/
" ▸ nerdtree/
" ▸ vim-airline/
" ▸ vim-fugitive/
" ▸ vim-gitgutter/
" ▸ vim-less/
" ▸ vim-multiple-cursors/
" ▸ vim-obsession/
" ▸ vim-tmux-navigator/
" ▸ vim-twig/
execute pathogen#infect()

" enable loading the plugin files for specific file types
filetype plugin indent on

syntax enable                  " Syntax-highlighting
set background=dark            "
set t_Co=256                   " Post 1950's mode
set number                     " Show line nos.
set wrap!                      " Word-wrap off
set ignorecase                 " Case-insensitivity
set softtabstop=2              " Number of space chars a tab counts for
set shiftwidth=2               " Number of space chars for indentation
set expandtab                  " Insert space characters whenever the tab key is pressed
set tabstop=2                  " Space chars inserted when tab key is pressed
set autoindent                 " Copy indent from current line when starting a new line
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set listchars=tab:▸\ ,eol:¬    " Use the same symbols as TextMate for tabstops and EOLs
set nobackup
set nowritebackup
set noswapfile

" Reload your config
nmap <leader>r :so ~/.vimrc<CR>

" Go back to normal mode
:inoremap kj <Esc>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" let g:ctrlp_cmd = 'CtrlPMixed'

" Remove trailling whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" toggle paste
nmap <leader>p :set paste!<CR>
" Copy out to OS X clipboard
vmap <C-c> :w !pbcopy<CR><CR>

" Map some unobtrusive tab-switching keys
nnoremap - :tabprevious<CR>
nnoremap = :tabnext<CR>

" For moving between panes easier
  " (Have to tell NERDTree that we want these keys, first)
  " let NERDTreeMapJumpLastChild='\<C-J>'
  " let NERDTreeMapJumpFirstChild='\<C-K>'
" once upon a time, we needed this... vim-tmux-navigator gives us <c-j,k,h,l>
" nnoremap J <C-W><Down>
" nnoremap K <C-W><Up>
" nnoremap H <C-W><Left>
" nnoremap L <C-W><Right>

" Even out the windows easier
nmap <leader>= <C-W>=

" Window resizing (narrower-width, wider-width, shorter-height, taller-height)
nmap < <C-W><
nmap > <C-W>>
" nmap <C-W>, <C-W>-
" nmap <C-W>. <C-W>+

" Get off my lawn (h/t @molly)
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

" NERDTree - close if it's all that's left open
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <leader>a :NERDTreeToggle<CR>

" The fancy powerline stuff
let g:airline_powerline_fonts = 1

" Because my default theme isn't already handling this.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight VertSplit cterm=NONE ctermfg=DarkBlue  ctermbg=DarkBlue

" Enabling GitGutter (Fish isn't POSIX compliant)
set shell=/bin/bash
let g:gitgutter_realtime = 1
let g:updatetime = 1000

" Some help for emmet.vim:
let g:user_emmet_mode='in'
let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'twig' : {
  \    'extends' : 'html',
  \  },
  \}

" CSS preprocessing... read 'em as their compile-to language.
autocmd BufNewFile,BufRead *.scss set ft=scss.css
autocmd BufNewFile,BufRead *.less set ft=less.css

