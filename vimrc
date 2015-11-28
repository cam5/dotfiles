" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Include Plugins
" ▸ ack.vim/
" ▸ ctrlp.vim/
" ▸ emmet-vim/
" ▸ nerdtree/
" ▸ tabular/
" ▸ limelight/
" ▸ vdebug/
" ▸ vim-airline/
" ▸ vim-autoclose/
" ▸ vim-fugitive/
" ▸ vim-gitgutter/
" ▸ vim-less/
" ▸ vim-multiple-cursors/
" ▸ vim-obsession/
" ▸ vim-surround/
" ▸ vim-tmux-navigator/
" ▸ vim-twig/
" ▸ vim-unimpaired/
" ▸ PIV/
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
set scrolloff=999              " keep scrolled line in the middle

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
set pastetoggle=<leader>p
" Copy out to OS X clipboard
vmap <C-c> :w !pbcopy<CR><CR>

" Map some unobtrusive tab-switching keys
nnoremap - :tabprevious<CR>
nnoremap = :tabnext<CR>

" Search Options
set hlsearch   " Highlight search
nmap <leader>s :set hlsearch!<CR>
set magic      " Set magic on, for regular expressions
set ignorecase " Searches are Non Case-sensitive
set smartcase

" https://github.com/junegunn/limelight.vim
let g:limelight_conceal_ctermfg     = 'gray'
let g:limelight_default_coefficient = 0.7

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"🎶  To the right, to the right 🎶
let g:NERDTreeWinPos = "right"

" Toggle the File drawer.
nmap <leader>' :NERDTreeToggle<CR>

" The fancy powerline stuff
let g:airline_powerline_fonts = 1

" Because my default theme isn't already handling this.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=235 gui=NONE guifg=DarkGrey guibg=NONE
highlight VertSplit cterm=NONE ctermbg=236
set fillchars=

" Enabling GitGutter (Fish isn't POSIX compliant)
set shell=/bin/bash
let g:gitgutter_realtime = 1
let g:updatetime = 1000
set numberwidth=5

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

" Never make a mistake again!
let g:airline#extensions#syntastic#enabled = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_scss_scss_lint_args = '-c ~/.scss-lint.yml'
let g:syntastic_html_tidy_args = '-config ~/.tidy.conf'

" Automatically close html tags with omni completion
" and keep editing in between the tags
imap <silent> </ </<C-X><C-O><Esc>T<hi

"" Make emmett a little more like it was in the ST3 days.
nmap <tab> <C-y>,i

" Nice little shortcut for js object tabularizing, via VimCasts
vmap <leader>; :'<,'>Tabularize /:\zs<CR>

" Just go absolutely crazy and cede all autonomy to the computers
" H/T @ http://stackoverflow.com/a/32117566/1779433
inoremap <silent> :   :<Esc>:call <SID>align(':')<CR>a
inoremap <silent> =   =<Esc>:call <SID>align('=')<CR>a

function! s:align(aa)
  let p = '^.*\s'.a:aa.'\s.*$'
  if exists(':Tabularize') && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^'.a:aa.']','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*'.a:aa.':\s*\zs.*'))
    exec 'Tabularize/'.a:aa.'/l1'
    normal! 0
    call search(repeat('[^'.a:aa.']*'.a:aa,column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

