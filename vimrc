" =================================================================
"  here is vim's default option
" =================================================================
set mouse=a                           " mouth
set encoding=utf-8
set fileencodings=utf-8
set fileencoding=utf-8
set fileformats=unix,dos,mac
set number                            " linege
set cursorline                        " pop up staing line
set tabstop=2                         " togther indent 
set autoindent                        " auto indent 
set smartindent                      " smart indent
set shiftwidth=2                      " Tab's size
set expandtab
set showmatch                       
set title                             " title
set statusline=%{F}
set noswapfile                        
set backspace=indent,eol,start        " backspace
set nocompatible                      " be iMproved
set clipboard=unnamed,autoselect      " c & p
set ignorecase
set hlsearch
" metals 
set updatetime=300
set nocursorline
set norelativenumber

"======================================= [ Nerdtree ] ==============================================
call plug#begin()
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'camspiers/animate.vim'
  Plug 'othree/html5.vim'
  Plug 'relastle/bluewery.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'plasticboy/vim-markdown'
  Plug 'kannokanno/previm'
  Plug 'tyru/open-browser.vim'
  Plug 'itchyny/calendar.vim'
  Plug 'Yggdroot/indentLine'
  Plug 'https://github.com/mizukmb/otenki.vim'
  Plug 'https://github.com/mattn/webapi-vim'
  Plug 'junegunn/goyo.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'leafgarland/typescript-vim'
  Plug 'alvan/vim-closetag'    
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'derekwyatt/vim-scala'
  Plug 'modess/vim-phpcolors'
  Plug 'tomasiser/vim-code-dark'
  Plug 'blueshirts/darcula'
  Plug 'scrooloose/nerdtree'
  Plug 'gre/play2vim'
  Plug 'digitaltoad/vim-pug'
  Plug 'curist/vim-angular-template'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'posva/vim-vue'
  Plug 'derekwyatt/vim-scala'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

filetype plugin indent on
filetype indent on

syntax on
autocmd FileType scala setlocal nomodeline

au BufNewFile,BufRead *.scala syntax keyword scalaIdentifier Ok

"colorscheme dark_plus
"colorscheme darcula
"colorscheme onedark
colorscheme nord

if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

let g:omni_sql_no_default_maps = 1

"====================================== [ Nerdtree ] =================================================
" auto Needtree
autocmd vimenter * NERDTree
autocmd TabNew * call timer_start(0, { -> execute('NERDTree') })
" when vim finished
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" find currnt file
nnoremap <C-l> :NERDTreeFind<Return>
" new Nerdtree
nnoremap n :NERDTree<Return>
"====================================== [ shortcut ] =================================================
nnoremap <M-D-up> :bo term<Return>

" move tab
nnoremap <D-M-right> gt
nnoremap <D-M-left> gT

" all select
noremap h ggVG

"Needtree tab chenge
noremap  <M-right> :tabNext<Enter>
noremap  <M-left> :tabprevious<Enter>
noremap  <C-t> :tabnew<Enter>
noremap  <S-left>  <C-w>h
noremap  <S-right> <C-w>w
nnoremap <D-d>     :vsplit<Return>
nnoremap <C-d>     :split<Return>

"Shift + Return -> esc
inoremap <S-Return> <ESC>
" when I'm staing, push q => quit 
nnoremap q :q

" Cursor select "
nnoremap <D-/> <C-v>
nnoremap <C-z> <C-^>

"========================================== [ fzf ] ==================================================
" fzf commands "
nnoremap ff :Files<Enter>
nnoremap <C-b> :BLines<Return>
nnoremap gh :History<Enter>
nnoremap gg :Gfiles<Enter>
nnoremap <C-f> :Rg<Enter>

" ff
command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" gg
command! -bang -nargs=? -complete=dir GFiles
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" rg
command! -bang -nargs=? -complete=dir Rg
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
"========================================== [ metals ] ===================================================
" metals
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy :<C-u>call CocAction('doHover')<cr>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <C-e> :lopen<Enter>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" metals build
nnoremap call :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' })

"============================================ [ other ] ===================================================

" indent nest
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" autocomplete
inoremap <TAB> <C-n>

nnoremap <C-s> :syntax on<Enter>

" color group name
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
      \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
      \   <bang>0)

"============================================ [ markdown preview ] =================================================
au BufRead,BufNewFile *.md set filetype=markdown
"============================================= [ google calender ] ==================================================
"nnoremap <C-c> :Calendar -day<Enter>
"let g:calendar_google_calendar = 1
"let g:calendar_google_task     = 1
"================================================= [ tenki ] ========================================================
nnoremap <space>o :Otenki<Return>

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" カーソル下のhighlight情報を表示する {{{
function! s:get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
    execute "highlight " . s:get_syn_name(s:get_syn_id(0))
    execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()

let g:fzf_layout = {
 \ 'window': 'new | wincmd J | resize 1 | call animate#window_percent_height(0.5)'
\ }

nnoremap <silent> <C-Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <C-Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <C-Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <C-Right> :call animate#window_delta_width(-10)<CR>


"let g:lightline = {
"        \ 'colorscheme': 'onedark',
"        \ 'mode_map': {'c': 'NORMAL'},
"        \ 'active': {
"        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
"        \ },
"        \ 'component_function': {
"        \   'modified': 'LightlineModified',
"        \   'readonly': 'LightlineReadonly',
"        \   'fugitive': 'LightlineFugitive',
"        \   'filename': 'LightlineFilename',
"        \   'fileformat': 'LightlineFileformat',
"        \   'filetype': 'LightlineFiletype',
"        \   'fileencoding': 'LightlineFileencoding',
"        \   'mode': 'LightlineMode'
"        \ }
"        \ }
"
"function! LightlineModified()
"  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
"endfunction
"
"function! LightlineReadonly()
"  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
"endfunction
"
"function! LightlineFilename()
"  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
"        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
"        \  &ft == 'unite' ? unite#get_status_string() :
"        \  &ft == 'vimshell' ? vimshell#get_status_string() :
"        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
"        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
"endfunction
"
"function! LightlineFugitive()
"  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
"    return fugitive#head()
"  else
"    return ''
"  endif
"endfunction
"
"function! LightlineFileformat()
"  return winwidth(0) > 70 ? &fileformat : ''
"endfunction
"
"function! LightlineFiletype()
"  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
"endfunction
"
"function! LightlineFileencoding()
"  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
"endfunction
"
"function! LightlineMode()
"  return winwidth(0) > 60 ? lightline#mode() : ''
"endfunction

let g:airline_theme='onedark'
set ambiwidth=double

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'papercolor'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'

