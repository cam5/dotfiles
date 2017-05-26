" vim:fdm=marker

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
set rtp+=~/.fzf                                " Add fzf's dir to runtimepath... it has vim plugs in it.

" enable loading the plugin files for specific file types
" enable indentation file based on file type
filetype plugin indent on

" Use the wonderful sierra as default colourscheme
colorscheme sierra

" Use the spacebar as the leader.
let mapleader=" "

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Let linter at some other linters (phpcs), in composer libs
let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
"}}}

" autocmds {{{
" Remove trailling whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" 2-space indent for certain filetypes.
autocmd BufRead,BufNewFile *.js,*.ts,*.feature,*.scss,*.css setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Wrap text at 80 lines when we're markdowning @see https://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile *.md set ft=markdown

" Specify that for PHP files, use phpcomplete as the omnifunc
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"}}}

" foundational-aliases {{{
" Go back to normal mode
:inoremap kj <Esc>

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

" Aliases
nmap <c-]><c-]> :call FzfTagsCurrentWord()<CR>
nmap <c-p> :Files<CR>
nmap <c-b> :Buffers<CR>
nmap <c-f> :Find<space>

" Populates FZF with a search based on the word under the cursor
function! FzfTagsCurrentWord()
  let currWord = expand('<cword>')
  call fzf#vim#tags(currWord)
endfunction

" h/t http://bit.ly/2qeNqPc
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --glob "!{.git/*,tags}" --color "always" '.shellescape(<q-args>), 1, <bang>0)
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder and the tags file)
" --color: Search color options
" }}}

" limelight {{{
nmap <leader>ll :Limelight!!0.8<CR>

" https://github.com/junegunn/limelight.vim
let g:limelight_conceal_ctermfg     = 'gray'
let g:limelight_paragraph_span      = 3
" }}}

" NERDTree {{{
" Close if it's all that's left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"🎶  To the right, to the right 🎶
let g:NERDTreeWinPos = "right"

" Toggle the File drawer.
nmap <leader>; :NERDTreeToggle<CR>
" }}}

" tabularize {{{
" Nice little shortcuts for js object tabularizing, h/t VimCasts
vmap <leader>\ :'<,'>Tabularize /\|<CR>:'<,'>Tabularize /=<CR>:'<,'>Tabularize /:\zs<CR>
vmap <leader>= :'<,'>Tabularize /=<CR>
vmap <leader>; :'<,'>Tabularize /:\zs<CR>
vmap => :'<,'>Tabularize /=><CR>
" }}}

" VimWiki {{{
let g:vimwiki_list = [{'path':'~/.vimwiki',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'path_html': '~/vimwiki',
  \ 'custom_wiki2html': '~/tmp/wiki2html.sh'
  \ }]

let g:vimwiki_folding = 'expr'
" }}}

" ALE {{{
let g:loaded_ale_linters_php_phpcs = 1
let g:ale_php_phpcs_standard = get(g:, 'ale_php_phpcs_standard', $HOME."/.phpcs.xml")
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger="df"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" }}}
"}}}

" statusline {{{
" Focussed statusline
highlight Statusline term=bold,reverse ctermfg=240 ctermbg=236 guifg=#585858 guibg=#303030

" Non-focussed statusline
highlight StatuslineNC term=bold,reverse ctermfg=238 ctermbg=236 guifg=#262626 guibg=#303030

" Statusline format
set statusline=%F:%l⧸%L%M%r\ %{&ff}%Y\ [%p%%]\%h%w\ %{fugitive#head()}\ [%{ALEGetStatusLine()}]
"              |  |  | | |   |     |    |     | |   |                   |
"              |  |  | | |   |     |    |     | |   |                   +-- [Ale errors]
"              |  |  | | |   |     |    |     | |   |
"              |  |  | | |   |     |    |     | |   +-- Git branch
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
"}}}

" macbook-only {{{
if hostname() == "cambook.local"
    set shell=/usr/local/Cellar/bash/4.4.12/bin/bash
    " Copy out to OS X clipboard
    vmap <C-c> :w !pbcopy<CR><CR>
    " Use our goofy cowsay header when we know the binary is available
    let g:startify_custom_header =
            \ map(split(system('date | cowsay -f moose'), '\n'), '"   ". v:val')

    " Indicates we installed with brew
    set rtp+=/usr/local/opt/fzf
endif
"}}}

" Things I'm in the process of testing
if filereadable($HOME . "/.vimrc.extra")
  execute('source ' . $HOME . '/.vimrc.extra')
endif

