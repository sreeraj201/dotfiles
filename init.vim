set rtp+=~/.fzf
set timeoutlen=1000
set ttimeoutlen=0

set inccommand=split

set relativenumber number
set guicursor=
set wildmenu
set laststatus=2
set nohlsearch
set noshowmode

" No swaps and backups
set nobackup
set nowritebackup
set noswapfile

syntax enable
filetype plugin indent on


" Colors
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Python support
let g:python2_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Comment
Plug 'tomtom/tcomment_vim'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Shougo
" Autocompletion, Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'

" Linting and formatting
Plug 'neomake/neomake' | Plug 'sbdchd/neoformat'

" Git plugins
Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter' 

" Junegunn
" Searching FZF
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo' | Plug 'junegunn/gv.vim'

" Tpope
Plug 'tpope/vim-surround' | Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired' | Plug 'tpope/vim-repeat'

" Python
Plug 'alfredodeza/pytest.vim', { 'for': 'python' }
Plug 'bfredl/nvim-ipy' | Plug 'bfredl/nvim-jupyter'

" Testing with terminal
Plug 'janko-m/vim-test' | Plug 'kassio/neoterm'

" Airline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Misc
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'Yggdroot/indentLine' | Plug 'nathanaelkane/vim-indent-guides'
Plug 'ervandew/supertab'
Plug 'vimwiki/vimwiki'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }

" Colorscheme
Plug 'rakr/vim-one'

call plug#end()

" Colorscheme
set background=dark 
colorscheme one

" Terminal navigation 
tnoremap <A-q> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l



" Deoplete
let g:deoplete#enable_at_startup = 1

" Airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" IndentLine
let g:indentLine_setColors = 0

let mapleader = ','

" Easy Motion
nmap <leader>f H:call EasyMotion#WB(0, 0)<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<cr>

" Nerdtree
let NERDTreeWinSize = 23
nmap <leader>ne :NERDTreeFocus<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Neosnippets
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


" Neomake
let g:neomake_open_list = 2
autocmd! BufWritePost * Neomake
let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202,E303',  '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['flake8']
""" define error symbols in gutter

let g:neomake_error_sign = {
  \ 'text': '✖',
  \ 'texthl': 'ErrorMsg',
  \ }
let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_list_height=2

" Test
map <silent> <leader>tt :TestNearest<CR>
map <silent> <leader>tf :TestFile<CR>
map <silent> <leader>tT :TestSuite<CR>
map <silent> <leader>tr :TestLast<CR>
map <silent> <leader>tg :TestVisit<CR>
let test#strategy = "neoterm"
" vertical split instead of the default horizontal
let g:neoterm_position = "vertical"

" Pytest
nmap <silent><Leader>ptf <Esc>:Pytest file<CR>
nmap <silent><Leader>ptc <Esc>:Pytest class<CR>
nmap <silent><Leader>ptm <Esc>:Pytest method<CR>
nmap <silent><Leader>pts <Esc>:Pytest session<CR> <bar> <C-j>
nmap <silent><Leader>ptu <Esc>:Pytest function<CR>

" Neoformat 
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" Vim Ipython
map <silent> <c-s>   <Plug>(IPy-Run)


" Fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Windows<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd VimEnter,ColorScheme * call s:update_fzf_colors()
augroup END
