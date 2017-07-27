" This is the only line that matters, it's the only different one.
let g:vimwiki_bullet_types = { '-':0, '*':0, '+':0, '>':0 }

" Everything else here is a copy from bundles/vimwiki/syntax/vimwiki_markdown.vim,
" in order to get the overriding right.
let g:vimwiki_rxListBullet = join( map(keys(g:vimwiki_bullet_types),
        \'vimwiki#u#escape(v:val).repeat("\\+", g:vimwiki_bullet_types[v:val])'
        \ ) , '\|')

let g:vimwiki_rxListItemWithoutCB = '^\s*\%(\('.g:vimwiki_rxListBullet.'\)\|\('.g:vimwiki_rxListNumber.'\)\)\s'
let g:vimwiki_rxListItem = g:vimwiki_rxListItemWithoutCB . '\+\%(\[\(['.g:vimwiki_listsyms.']\)\]\s\)\?'
let g:vimwiki_rxListItemAndChildren = '^\(\s*\)\%('.g:vimwiki_rxListBullet.'\|'.g:vimwiki_rxListNumber.'\)\s\+\['.g:vimwiki_listsyms_list[-1].'\]\s.*\%(\n\%(\1\s.*\|^$\)\)*'


