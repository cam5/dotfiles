" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Include Plugins
"
" ▸ ag.vim
" ▸ ctrlp.vim
" ▸ emmet-vim
" ▸ goyo
" ▸ limelight
" ▸ nerdtree
" ▸ padawan.vim
" ▸ phpcomplete.vim
" ▸ syntastic
" ▸ tabular
" ▸ typescript-vim
" ▸ vim-airline
" ▸ vim-fugitive
" ▸ vim-gitgutter
" ▸ vim-less
" ▸ vim-obsession
" ▸ vim-php-cs-fixer
" ▸ vim-startify
" ▸ vim-surround
" ▸ vim-tmux-navigator
" ▸ vim-twig
" ▸ vim-unimpaired
" ▸ vimwiki
execute pathogen#infect()

" enable loading the plugin files for specific file types
filetype plugin indent on

set omnifunc=syntaxcomplete#Complete

au FileType php set omnifunc=phpcomplete#CompletePHP

syntax enable                                  " Syntax-highlighting
set t_Co=256                                   " Post 1950's mode
set number                                     " Show line #s.
set nowrap                                     " Word-wrap off
set ignorecase                                 " Case-insensitivity
set softtabstop=4                              " Number of space chars a tab counts for
set shiftwidth=4                               " Number of space chars for indentation
set expandtab                                  " Insert space characters whenever the tab key is pressed
set tabstop=4                                  " Space chars inserted when tab key is pressed
set autoindent                                 " Copy indent from current line when starting a new line
set smarttab                                   " Helps to backspace over space-tabs
set cursorline                                 " Check yoself
set backspace=indent,eol,start                 " allow backspacing over everything in insert mode
set list                                       " \
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:. " - Highlight trailing whitespace, tabs, and note lines that extend offscreen.
set nobackup                                   "\
set nowritebackup                              " } We'll take our chances.
set noswapfile                                 "/
set scrolloff=1                                " scroll buffer of one line.
set clipboard=unnamed                          " Use the quotestar register for all yank, delete, change, and put operations that have no register explicitly specified
                                               " @h/t: http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
set hlsearch                                   " Highlight search
set magic                                      " Set magic on, for regular expressions (special characters)
set ignorecase                                 " Searches are Non-case-sensitive
set smartcase                                  " Override the 'ignorecase' option if the search pattern contains upper case characters.

set numberwidth=5

" Use an updated bash, on MacBook
if hostname() == "cambook.local"
    set shell=/usr/local/Cellar/bash/4.3.42/bin/bash
else
    set shell=/bin/bash
endif

" Use the spacebar as the leader.
let mapleader=" "

" Reload your config
nmap <leader>r :so ~/.vimrc<CR>

" Go back to normal mode
:inoremap kj <Esc>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
endif

" Remove trailling whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" shortcut to rapidly toggle error list
nmap <leader>l :lopen<CR>

" toggle paste
nmap <leader>p :set paste!<CR>
" Copy out to OS X clipboard
vmap <C-c> :w !pbcopy<CR><CR>
" Quick yanking to the end of the line
nnoremap Y y$

" Map some unobtrusive tab-switching keys
nnoremap g- :tabprevious<CR>
nnoremap g= :tabnext<CR>
nnoremap <C-w><C-h> :tabprevious<CR>
nnoremap <C-w><C-l> :tabnext<CR>
nnoremap <C-w><C-j> :tabprevious<CR>
nnoremap <C-w><C-k> :tabnext<CR>

" Ayy what is this, a web browser?
nnoremap <C-t> :tabe<CR>

" Search Options
nmap <leader>s :set hlsearch!<CR>

" https://github.com/junegunn/limelight.vim
let g:limelight_conceal_ctermfg     = 'gray'
let g:limelight_paragraph_span      = 1
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
"
let NERDTreeDirArrowCollapsible = '▾'
let NERDTreeDirArrowExpandable = '›'

vmap <C-c> :w !pbcopy<CR><CR>

" Even out the windows easier
nmap <leader>= <C-W>=

" Window resizing (narrower-width, wider-width, shorter-height, taller-height)
nmap < <C-W><
nmap > <C-W>>
" nmap <C-W>, <C-W>-
" nmap <C-W>. <C-W>+

" Copy that nice little keybinding from vimuim
nmap << :tabmove -1<CR>
nmap >> :tabmove +1<CR>

" Get off my lawn (h/t @molly)
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

" NERDTree - close if it's all that's left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Wrap text at 80 lines when we're markdowning
" https://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.md set ft=markdown

"🎶  To the right, to the right 🎶
let g:NERDTreeWinPos = "right"

" Toggle the File drawer.
nmap <leader>; :NERDTreeToggle<CR>

" The fancy powerline stuff
let g:airline_powerline_fonts = 1

" Enabling GitGutter (Fish isn't POSIX compliant)
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

" Never make a mistake again!
let g:airline#extensions#syntastic#enabled = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_scss_scss_lint_args = '-c ~/.scss-lint.yml'
let g:syntastic_html_tidy_args = '-config ~/.tidy.conf'
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--report=csv --standard=' . $HOME . '/.phpcs.xml'
let g:syntastic_stl_format = '%E{Err. %e}%B{, }%W{War. %w}'
let g:syntastic_error_symbol = "●"
let g:syntastic_warning_symbol = "●"
let g:syntastic_style_error_symbol = "●"
let g:syntastic_style_warning_symbol = "●"

" Automatically close html tags with omni completion
" and keep editing in between the tags
" imap <silent> </ </<C-X><C-O><Esc>T<hi

"" Make emmett a little more like it was in the ST3 days.
nmap <tab> <C-y>,i
imap <leader><tab> <C-y>

" Nice little shortcuts for js object tabularizing, h/t VimCasts
vmap <leader>\ :'<,'>Tabularize /\|<CR>:'<,'>Tabularize /=<CR>:'<,'>Tabularize /:\zs<CR>
vmap <leader>= :'<,'>Tabularize /=<CR>
vmap <leader>; :'<,'>Tabularize /:\zs<CR>
vmap => :'<,'>Tabularize /=><CR>

" Let syntastic at some other linters (phpcs), in composer libs
let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')

nnoremap <leader>S :SyntasticToggleMode<CR>

" VimWiki
let g:vimwiki_list = [{'path':'~/.vimwiki',
  \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'

" Startify (but only on MacBook)
if hostname() == "cambook.local"
    let g:startify_custom_header =
            \ map(split(system('date | cowsay -f moose'), '\n'), '"   ". v:val')
endif

nmap <leader>f :echo @%<CR>

" Things I'm in the process of testing
if filereadable($HOME . "/.vimrc.extra")
  execute('source ' . $HOME . '/.vimrc.extra')
endif

