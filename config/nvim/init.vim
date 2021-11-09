" vim:fdm=marker

source ~/.vim/autoload/pathogen.vim
source ~/.vimrc

execute pathogen#infect('~/.vim/bundle/{}')

" Invoke neovim-only bundles
execute pathogen#infect('~/.config/nvim/bundle/{}')

" Reload this config, not just vimrc.
nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" GitGutter
hi DiffAdd ctermbg=64

" Tab Colors
hi Tabline ctermfg=243
hi TablineSel ctermfg=254

"ALE Config {{{
  let g:ale_enabled = 0
  let g:ale_sign_error = '→'
  let g:ale_sign_warning = '•'
  hi ALEErrorSign ctermbg=236 ctermfg=167
  hi ALEWarningSign ctermbg=236 ctermfg=95

  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'php': ['hack', 'php', 'phpcs', 'phpmd'],
  \   'scss': ['scsslint']
  \}

  let g:ale_fixers = { 'javascript': ['eslint'] }
"}}}

source ~/.config/nvim/lua/init.lua
