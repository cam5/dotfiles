" Each theme is contained in its own file and declares variables scoped to the
" file.  These variables represent the possible "modes" that airline can
" detect.  The mode is the return value of mode(), which gets converted to a
" readable string.  The following is a list currently supported modes: normal,
" insert, replace, visual, and inactive.
"
" Each mode can also have overrides.  These are small changes to the mode that
" don't require a completely different look.  "modified" and "paste" are two
" such supported overrides.  These are simply suffixed to the major mode,
" separated by an underscore.  For example, "normal_modified" would be normal
" mode where the current buffer is modified.
"
" The theming algorithm is a 2-pass system where the mode will draw over all
" parts of the statusline, and then the override is applied after.  This means
" it is possible to specify a subset of the theme in overrides, as it will
" simply overwrite the previous colors.  If you want simultaneous overrides,
" then they will need to change different parts of the statusline so they do
" not conflict with each other.
"
" First, let's define an empty dictionary and assign it to the "palette"
" variable. The # is a separator that maps with the directory structure. If
" you get this wrong, Vim will complain loudly.
let g:airline#themes#sierra#palette = {}

" First let's define some arrays. The s: is just a VimL thing for scoping the
" variables to the current script. Without this, these variables would be
" declared globally. Now let's declare some colors for normal mode and add it
" to the dictionary.  The array is in the format:
" [ guifg, guibg, ctermfg, ctermbg, opts ]. See "help attr-list" for valid
" values for the "opt" value.
let s:N1   = [ '#262626' , '#dfdf87' , 235  , 186 ]
let s:N2   = [ '#e4e4e4' , '#4e4e4e' , 254 , 239 ]
let s:N3   = [ '#e4e4e4' , '#262626' , 254  , 235 ]
let g:airline#themes#sierra#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#sierra#palette.normal, hence why only certain keys are
" declared.
let g:airline#themes#sierra#palette.normal_modified = {
      \ 'airline_c': [ '#e4e4e4' , '#4e4e4e' , 254     , 239    , ''     ] ,
      \ }


let s:I1 = [ '#262626' , '#5f8787' , 235  , 66  ]
let s:I2 = [ '#e4e4e4' , '#262626' , 254 , 239  ]
let s:I3 = [ '#e4e4e4' , '#262626' , 254  , 235  ]
let g:airline#themes#sierra#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#sierra#palette.insert_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 254     , 239      , ''     ] ,
      \ }
let g:airline#themes#sierra#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#87afaf' , s:I1[2] , 109     , ''     ] ,
      \ }


let g:airline#themes#sierra#palette.replace = copy(g:airline#themes#sierra#palette.insert)
let g:airline#themes#sierra#palette.replace.airline_a = [ s:I2[0]   , '#af5f5f' , s:I2[2] , 131     , ''     ]
let g:airline#themes#sierra#palette.replace_modified = g:airline#themes#sierra#palette.insert_modified


let s:V1 = [ '#262626' , '#87d787' , 235 , 114 ]
let s:V2 = [ '#e4e4e4' , '#4e4e4e' , 254 , 239 ]
let s:V3 = [ '#e4e4e4' , '#262626' , 254  , 235  ]
let g:airline#themes#sierra#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#sierra#palette.visual_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 239     , ''     ] ,
      \ }


let s:IA1 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:IA3 = [ '#4e4e4e' , '#3a3a3a' , 239 , 237 , '' ]
let g:airline#themes#sierra#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
let g:airline#themes#sierra#palette.inactive_modified = {
      \ 'airline_c': [ '#dfaf5f' , '' , 179 , '' , '' ] ,
      \ }


" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the 'readonly'
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let g:airline#themes#sierra#palette.accents = {
      \ 'red': [ '#d75f5f' , '' , 167 , ''  ]
      \ }


" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#sierra#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#d7d7ff' , '#5f00af' , 189 , 66  , ''     ],
      \ [ '#ffffff' , '#875fd7' , 231 , 66  , ''     ],
      \ [ '#5f00af' , '#ffffff' , 234 , 152 , 'bold' ])

