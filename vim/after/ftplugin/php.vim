" Linting {{{
let g:loaded_ale_linters_php_phpcs = 1
let g:ale_php_phpcs_standard = get(g:, 'ale_php_phpcs_standard', $HOME . "/.phpcs.xml")

" Override w/ local phpcs where present.
if filereadable($PWD . "/.phpcs.xml")
    let g:ale_php_phpcs_standard = $PWD . "/.phpcs.xml"
endif

" Let linter at some other linters like phpcs, for example in the global and/or local composer libs
if isdirectory($PWD . './vendor/bin')
    let $PATH=$PWD . ':' . expand('./vendor/bin')
endif

if isdirectory($HOME . '~/.composer/vendor/bin')
    let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
endif
" }}}


" Highlight {{{
    hi! link phpDocTags phpDefine
    hi! link phpDocParam phpBoolean
" }}}
