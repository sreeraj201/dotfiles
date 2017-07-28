set encoding=utf8
" Powerline
" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set timeoutlen=1000
set ttimeoutlen=0
set termguicolors

" Always show statusline
set laststatus=2
" no swap and backup
set nobackup
set nowritebackup
set noswapfile
set wildmenu

set tabstop=4
set softtabstop=4
set expandtab
set nofoldenable

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
" set t_Co=256
set relativenumber
set number
execute pathogen#infect()
filetype plugin indent on

set nocompatible
filetype off

set background=dark
colorscheme gruvbox

" Auto resize Vim splits to active split
" set winwidth=75
" set winheight=5
" set winminheight=5
" set winheight=999

" set incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" Airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

syntax on

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set pastetoggle=<F2>
map <C-Tab> :bn<cr>

let g:vim_markdown_folding_style_pythonic=1

command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>

set pastetoggle=<F2>

let python_highlight_all = 1

let mapleader = ","

" Easy motion
nmap <leader>f H:call EasyMotion#WB(0, 0)<CR>

" Nerd Tree
let NERDTreeWinSize = 23
" let g:nerdtree_tabs_open_on_console_startup=1

nmap <leader>ne :NERDTreeFocus<cr>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" PyMode
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0

" Session
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" Vimux
" Run the current file with rspec
" map <Leader>vr :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" Prompt command
map <Leader>vp :VimuxPromptCommand<CR>
" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane map
map <Leader>vs :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vs vip<LocalLeader>vs<CR>

vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars
let g:tslime_always_current_session = 1 
let g:tslime_always_current_window = 1

" UndoTree
nnoremap <leader>u :undotreetoggle<cr>


" Syntastic
function Py2()
  let g:syntastic_python_python_exec = '/usr/local/bin/python2.7'
endfunction

function Py3()
  let g:syntastic_python_python_exec = '/usr/local/bin/python3.6'
endfunction

call Py3()   " default to Py3 because I try to use it when possible

" Autopep8
noremap <F8> :PymodeLintAuto <CR>
" ignore pep (long lines) 
" let g:pymode_lint_ignore="E501,W601"
" let g:pymode_rope=0

" Pytest
nmap <silent><Leader>ptf <Esc>:Pytest file<CR>
nmap <silent><Leader>ptc <Esc>:Pytest class<CR>
nmap <silent><Leader>ptm <Esc>:Pytest method<CR>
nmap <silent><Leader>pts <Esc>:Pytest session<CR> <bar> <C-j>
nmap <silent><Leader>ptu <Esc>:Pytest function<CR>


" Youcomplete me
" let g:ycm_add_preview_to_completeopt = 0

set completeopt-=preview

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Fzf

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

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

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<Right>"
let g:UltiSnipsJumpBackwardTrigger = "<Left>"


