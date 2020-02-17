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

"======================================= [ Nerdtree ] ==============================================
call plug#begin()
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
colorscheme darcula
"colorscheme onedark
"colorscheme solarized
"colorscheme bluewery
"let g:lightline = { 'colorscheme': 'bluewery' }
"let g:lightline = { 'colorscheme': 'bluewery_light' }

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
nnoremap <C-c> :Calendar -day<Enter>
let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1
"================================================= [ tenki ] ========================================================
nnoremap <space>o :Otenki<Return>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
