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

source ~/.config/nvim/lua/init.lua
