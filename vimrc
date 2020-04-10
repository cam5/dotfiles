" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Include Plugins
execute pathogen#infect()

"initial settings {{{

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
set nobackup                                   " \
set nowritebackup                              " - We'll take our chances.
set noswapfile                                 " /
set scrolloff=1                                " scroll buffer of one line.
set clipboard=unnamed                          " Use the quotestar register for all yank, delete, change, and put operations that have no register explicitly specified
                                               " @h/t: http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
set nofoldenable                               " Where there are folds, disable on start
set hlsearch                                   " Highlight search
set magic                                      " Set magic on, for regular expressions (special characters)
set ignorecase                                 " Searches are Non-case-sensitive
set smartcase                                  " Override the 'ignorecase' option if the search pattern contains upper case characters.
set fillchars=
set modeline                                   " allows vim settings to be loaded using modeline syntax at head/foot of files
set shell=/bin/bash                            " use bash as default shell
set numberwidth=5
set omnifunc=syntaxcomplete#Complete           " By default, just see what completions are offered based on the syntax
set relativenumber
set rtp+=~/.vim/after

" enable loading the plugin files for specific file types
" enable indentation file based on file type
filetype plugin indent on

" Use the wonderful sierra as default colourscheme;
silent! colorscheme sierra    " fail silently if it's not there.

" Use the spacebar as the leader.
let mapleader=" "

" modified from https://superuser.com/a/120011
" (we can usually rely on $HOME, but stil...)
let $VIMHOME=expand('<sfile>:p:h')
"                    |       | \ modifier that removes last node in filepath
"                    |       \ modifier that gets full path to...
"                    \ sourced file

"}}}

" autocmds {{{
" Remove trailling whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" 2-space indent for certain filetypes.
autocmd BufRead,BufNewFile *.js,*.ts,*.feature,*.scss,*.css setlocal shiftwidth=2 softtabstop=2 tabstop=2
"}}}

" foundational-aliases {{{

" Go back to normal mode
:inoremap kj <Esc>

" Mimic systemwide behaviour for this <C-e> chord while in insert
:inoremap <C-e> <C-o>A
:inoremap <C-a> <C-o>I

" Buffer-jumping
nnoremap <BS> :b#<CR>

" No chording if you can help it!
nnoremap <leader>v <C-v>
nnoremap <C-v> :echoe "Do \<leader\>v"<CR>

" Sometimes you still need tabs...
:inoremap <S-Tab> <C-V><Tab>

" Reload config
nmap <leader>r :so ~/.vimrc<CR>

" shortcut to rapidly toggle error list
nmap <leader>l :lopen<CR>

" toggle paste
nmap <leader>p :set paste!<CR>

" Search Options
nmap <leader>s :set hlsearch!<CR>

" Quick yanking to the end of the line
nnoremap Y y$

"}}}

" window-tab-navigation {{{

" Map some unobtrusive tab-switching keys
nnoremap g- :tabprevious<CR>
nnoremap g= :tabnext<CR>
nnoremap <C-w><C-h> :tabprevious<CR>
nnoremap <C-w><C-l> :tabnext<CR>
nnoremap <C-w><C-j> :tabprevious<CR>
nnoremap <C-w><C-k> :tabnext<CR>

" Ayy what is this, a web browser?
nnoremap <C-t> :tabe<CR>

" Even out the windows easier
nmap <leader>= <C-W>=

" Window resizing (narrower-width, wider-width, shorter-height, taller-height)
nmap < <C-W><
nmap > <C-W>>

"}}}

" plugin-configs {{{


" FZF {{{

" Extend the runtimepath to include wherever you've installed FZF...
set rtp+=/usr/local/opt/fzf

if !empty(glob(expand($HOME . "/.vim/bundle/fzf.vim")))
  " Aliases
  nmap <c-]><c-]> :call FzfTagsCurrentWord()<CR>
  nmap <c-p> :GFiles<CR>
  nmap <c-b> :Buffers<CR>
  nmap <c-f> :Find<space>

  " Populates FZF with a search based on the word under the cursor
  function! FzfTagsCurrentWord()
    let currWord = expand('<cword>')
    call fzf#vim#tags(currWord)
  endfunction

  command! -bang -nargs=* Find
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --glob "!{.git/*,tags}" --color "always" '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
  " --column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder and the tags file)
  " --color: Search color options
endif

" }}}

" limelight {{{

if !empty(glob(expand($HOME . '/.vim/bundle/limelight.vim')))
  nmap <leader>ll :Limelight!!0.8<CR>

  " https://github.com/junegunn/limelight.vim
  let g:limelight_conceal_ctermfg     = 'gray'
  let g:limelight_paragraph_span      = 3
endif

" }}}

" NERDTree {{{

if !empty(glob(expand($HOME . '/.vim/bundle/nerdtree')))
  " Close if it's all that's left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  "🎶  To the right, to the right 🎶
  let g:NERDTreeWinPos = "right"

  let NERDTreeIgnore = ['\.pyc$']

  " Toggle the File drawer.
  nmap <leader>; :NERDTreeToggle<CR>
endif

" }}}

" VimWiki {{{

if !empty(glob(expand($HOME . '/.vim/bundle/vimwiki')))
  let g:vimwiki_list = [
    \ {
      \ 'path':'~/zettle',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'path_html': '~/zettle-html',
    \ }]

  let g:vimwiki_markdown_link_ext = 1
  let g:vimwiki_markdown_header_style = 1
  let g:vimwiki_folding = 'expr'
  let g:vimwiki_hl_headers = 1
  let g:vimwiki_hl_cb_checked = 1
  let g:vimwiki_list_margin = 0

  if !empty(glob(expand($HOME . "/.vim/bundle/fzf.vim"))) && !empty(glob(expand($HOME . '/.vim/bundle/vim-zettel'))) && executable('rg')
    let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
  endif
endif

" }}}

" Ultisnips {{{

let g:UltiSnipsExpandTrigger="df"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" }}}

" vim-easy-align {{{

if !empty(glob(expand($HOME . '/.vim/bundle/vim-easy-align')))
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

" }}}

" vim-gitgutter {{{

let g:gitgutter_async = 0

" }}}

"}}}

" statusline {{{

" Focussed statusline
highlight Statusline term=bold,reverse ctermfg=240 ctermbg=236 guifg=#585858 guibg=#303030

" Non-focussed statusline
highlight StatuslineNC term=bold,reverse ctermfg=238 ctermbg=236 guifg=#262626 guibg=#303030

" Statusline format
set statusline=%F:%l⧸%L%M%r\ %{&ff}%Y\ [%p%%]\%h%w
"              |  |  | | |   |     |    |     | |
"              |  |  | | |   |     |    |     | +-- Preview window flag
"              |  |  | | |   |     |    |     +-- Help buffer flag
"              |  |  | | |   |     |    +-- Percentage through file in lines
"              |  |  | | |   |     +-- Type of file in the buffer
"              |  |  | | |   +-- current fileformat
"              |  |  | | +-- Readonly flag
"              |  |  | +-- Modified flag
"              |  |  +-- Number of lines in buffer.
"              |  +-- Current line number
"              +-- Full path to the file in the buffer.

if !empty(glob(expand($HOME . '/.vim/bundle/vim-fugitive')))
  let &statusline.='\ %{fugitive#head()}'
endif

"}}}

" macbook-only {{{

if hostname() == "cambook.local"
  set shell=/usr/local/bin/zsh
endif

"}}}

" Things I'm in the process of testing
if filereadable($HOME . "/.vimrc.extra")
  execute('source ' . $HOME . '/.vimrc.extra')
endif

