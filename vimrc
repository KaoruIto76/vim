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
"set statusline=%{F}
set noswapfile                        
set backspace=indent,eol,start        " backspace
set nocompatible                      " be iMproved
set clipboard=unnamed,autoselect      " Hello world
set ignorecase
set hlsearch
" metals 
set updatetime=300
set nocursorline
set norelativenumber

" ======================================= [ Reader ]
let mapleader = "\<Space>"
"======================================= [ Nerdtree ]
call plug#begin()
  Plug 'itchyny/lightline.vim'
  "Plug 'relastle/bluewery.vim'
  Plug 'kannokanno/previm',{ 'for': ['md'] }
  Plug 'tyru/open-browser.vim',{ 'for': ['md'] }
  Plug 'Yggdroot/indentLine'
  Plug 'joshdick/onedark.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'othree/html5.vim',{ 'for': ['html'] }
  Plug 'leafgarland/typescript-vim',{ 'for': ['ts'] }
  Plug 'posva/vim-vue',{ 'for': ['vue'] }
  Plug 'digitaltoad/vim-pug',{ 'for': ['pug'] }
  Plug 'derekwyatt/vim-scala',{ 'for': ['scala'] }
  Plug 'gre/play2vim'
  Plug 'alvan/vim-closetag' 
  Plug 'tpope/vim-fugitive',{ 'on': 'Gdiff' }
  Plug 'tpope/vim-sensible'
  Plug 'blueshirts/darcula'
  Plug 'scrooloose/nerdtree',{ 'on': 'NERDTreeToggle' }
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set nocompatible

filetype plugin indent on
filetype indent on

syntax on
autocmd FileType scala setlocal nomodeline

au BufNewFile,BufRead *.scala syntax keyword scalaIdentifier Ok

"colorscheme dark_plus
"colorscheme darcula
colorscheme onedark
"colorscheme nord

if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

let g:omni_sql_no_default_maps = 1

" ===================================== [ usually command ]
noremap <Leader><C-s> :syntax on<Enter>
" 行頭へ移動
noremap <C-a> ^
inoremap <C-a> <Home>
" 行末へ移動
noremap <C-e> $
inoremap <C-e> <End>
nnoremap ˙ gT
nnoremap ¬ gt
noremap <C-s> o
noremap w b

nnoremap :term :bo term<Return>
nnoremap ; :

" move tab
nnoremap <D-M-right> gt
nnoremap <D-M-left> gT

"Needtree tab chenge
noremap  <C-t> :tabnew<Enter>
nnoremap <Leader>vs :vsplit<Return>
nnoremap <Leader>s  :split<Return>

"Shift + Return -> esc
inoremap <C-g> <ESC>
"====================================== [ Nerdtree ]
" auto Needtree
autocmd vimenter * NERDTree
autocmd TabNew * call timer_start(0, { -> execute('NERDTree') })
" when vim finished
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" find currnt file
nnoremap <Leader>sf :NERDTreeFind<Return>
" new Nerdtree
nnoremap <Leader>n :NERDTree<Return>

"========================================== [ fzf ]
" fzf commands "
nnoremap <Leader><C-f> :GFiles<Enter>
nnoremap <Leader><C-l> :BLines<Return>
nnoremap <Leader><C-h> :History<Enter>
nnoremap <Leader>ss :Rg<Enter>

" ff
command! -bang -nargs=? -complete=dir GFiles
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Rg
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
\ <bang>0)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
"========================================== [ metals ]
" metals
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy :<C-u>call CocAction('doHover')<cr>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" metals build
nnoremap call :call CocRequestAsync('metals', 'workspace/executeCommand', { 'command': 'build-import' })

"============================================ [ other ]

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

"============================================ [ markdown preview ]
au BufRead,BufNewFile *.md set filetype=markdown

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

syntax enable
set showtabline=2
let g:airline_theme = 'onedark'
" powerline enable(最初に設定しないとダメ)
let g:airline_powerline_fonts = 1
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1
" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0