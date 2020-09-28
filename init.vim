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
set clipboard=unnamed                 " Hello world
set ignorecase
set hlsearch
" metals 
set updatetime=300
set nocursorline
set norelativenumber
set termguicolors

" ======================================= [ Reader ]
let mapleader = "\<Space>"

" ===================================== [ usually command ]
tnoremap <silent> <C-g> <C-\><C-n>
tnoremap <silent> <Esc> <C-\><C-n>
 
noremap f /
noremap <Leader><C-s> :syntax on<Enter>
" 行頭へ移動
noremap <C-b> 0
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

"Needtree tab chenge
noremap  <Leader>v <C-v>
noremap  <Leader>t :tabnew<Enter>
nnoremap <Leader>vs :vsplit<Return>
nnoremap <Leader>s  :split<Return>

inoremap <C-g> <ESC>
noremap <Leader><C-g> :term lazygit<Enter>
inoremap <TAB> <C-n>

" ====================================================== [ dein ]
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('vim-airline/vim-airline')
  call dein#add('joshdick/onedark.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('digitaltoad/vim-pug')
  call dein#add('othree/html5.vim')
  call dein#add('gre/play2vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('alvan/vim-closetag')
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/fzf',{'build': './install --all'})
  call dein#add('junegunn/fzf.vim')
  call dein#add('neoclide/coc.nvim')
  call dein#add('Shougo/defx.nvim')
  call dein#add('markonm/traces.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable


" Required:
filetype plugin indent on
syntax enable

call map(dein#check_clean(), "delete(v:val, 'rf')")

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

colorscheme onedark
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
nmap <silent> <Leader>ws <Plug>(coc-metals-expand-decoration)
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy :<C-u>call CocAction('doHover')<cr>
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
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
" ====================================== [ defx[tree] ]
autocmd VimEnter * execute 'Defx'
nnoremap <silent> <Leader>n :<C-u> Defx <CR>

call defx#custom#option('_', {
      \ 'winwidth': 70,
      \ 'split': 'floating',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'exlorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'mark:indent:git:icons:filename:type',
      \ })

autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('multi',[['open','tabnew'],'quit'])
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#is_directory() ?
  \  defx#do_action('open_directory') :
  \ defx#do_action('multi',[['drop'], 'quit'])
  nnoremap <silent><buffer><expr> v
  \ defx#do_action('multi',[['open', 'vsplit'],'quit'])
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('multi',[['open', 'split'],'quit'])
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> a
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" Config for defx-git
call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

" ============================================== [ airline ]
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
