let uname = substitute(system('uname'), '\n', '', '')



if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"plugin for python execution"
Plug 'urbainvaes/vim-ripple'

Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'taohexxx/lightline-buffer'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips', {'tag': '3.2'} " fix Ultisnips#TrackChanges
Plug 'honza/vim-snippets'
" Plug 'w0rp/ale'
" Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'justinmk/vim-sneak'
Plug 'rhysd/committia.vim'
Plug 'vimwiki/vimwiki'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-dispatch'
Plug 'rhysd/git-messenger.vim'
Plug 'zhaocai/GoldenView.Vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

if has('nvim')
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-jedi'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/float-preview.nvim'
    Plug 'wellle/tmux-complete.vim'
endif

if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and install
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --completion --key-bindings --no-update-rc'}

" Themes
Plug 'drewtempelmeyer/palenight.vim'

" Plug 'KabbAmine/yowish.vim'

" Adding plugin for ipython to execute selected lines"
"
" Plug 'jupyter-vim/jupyter-vim'

call plug#end()

filetype plugin on
filetype indent on
syntax on
set hidden
set encoding=UTF-8
set relativenumber
set number
set autoread
set hlsearch
set backspace=indent,eol,start
set colorcolumn=80
set tabstop=4
set shiftwidth=4
set expandtab
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
set laststatus=2
set ttyfast
set lazyredraw
set re=1
set ignorecase
set smartcase
set noshowmode
set wildmenu
set wildignorecase
set noerrorbells
set showcmd
set conceallevel=0
set wildignore=*.o,*~,*.pyc,*.swp,*.swo,*DS_Store*,*.png,*.jpg,*.gif,*.pdf

if has('nvim')
    set inccommand=split
endif

if has("clipboard")
    if uname == 'Linux'
        set clipboard=unnamed
    endif
endif

let g:enable_bold_font = 1
" Comments in italic
highlight Comment cterm=italic

" FIXME Doesn't work on Linux (<C-$>)
if uname == 'Linux'
    nnoremap <C-]> <C-]>
endif

map <space> <leader>
nnoremap H ^
nnoremap L $
nnoremap U <C-R>
cnoremap %s/ %s/\v
nnoremap <leader>p :buffer #<CR>
cmap w!! w !sudo tee %

if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j
endif

" Options for session
set ssop-=options " do not store global and local values in a session

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    " Equivalent to ESC in terminal mode
    tnoremap <silent> <C-w> <C-\><C-n>

    " neovim-remote when using git inside terminal mode
    let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Misc
function! s:term_gf()
    let procid = matchstr(bufname(""), '\(://.*/\)\@<=\(\d\+\)')
    let proc_cwd = resolve('/proc/'.procid.'/cwd')
    exe 'lcd '.proc_cwd
    exe 'e <cfile>'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [{'path': '~/.vim/wiki', 'syntax': 'markdown'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_table_mappings = 0
let g:vimwiki_table_auto_fmt = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("persistent_undo")
    silent! call mkdir($HOME . "/.vim/undo", 'p')
    set undofile
    set undodir=$HOME/.vim/undo

let g:undotree_SetFocusWhenToggle = 1
nnoremap <leader>u :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sneak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

nnoremap s cl
nnoremap S cc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GoldenView
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:goldenview__enable_default_mapping = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NCM2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    let g:tmuxcomplete#trigger = ''

    augroup my_cm_setup
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
        autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-cmds',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'prefix', 'key': 'word'},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
            \ 'on_complete': ['ncm2#on_complete#omni',
            \                 'vimtex#complete#omnifunc'],
            \ })
        autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-labels',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'substr', 'key': 'word'},
            \               {'name': 'substr', 'key': 'menu'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#labels,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
        autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'vimtex-files',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'abbrfuzzy', 'key': 'word'},
            \               {'name': 'abbrfuzzy', 'key': 'abbr'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#files,
            \ 'on_complete': ['ncm2#on_complete#omni',
            \                 'vimtex#complete#omnifunc'],
            \ })
        autocmd Filetype tex call ncm2#register_source({
            \ 'name' : 'bibtex',
            \ 'priority': 8,
            \ 'complete_length': -1,
            \ 'scope': ['tex'],
            \ 'matcher': {'name': 'combine',
            \             'matchers': [
            \               {'name': 'prefix', 'key': 'word'},
            \               {'name': 'abbrfuzzy', 'key': 'abbr'},
            \               {'name': 'abbrfuzzy', 'key': 'menu'},
            \             ]},
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
    augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories = ['Ultisnips', 'custom_snippets']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:clang_format#style_options = {
    \ "AlignAfterOpenBracket": "true",
    \ "BreakBeforeBraces": "Allman",
    \ "BinPackParameters": "false",
    \ "BreakBeforeBinaryOperators": "NonAssignment",
    \ "AlwaysBreakBeforeMultilineStrings": "false",
    \ "BreakBeforeTernaryOperators": "true",
    \ "BreakConstructorInitializers": "AfterColon",
    \ "CompactNamespaces": "true",
    \ "SpaceAfterCStyleCast": "true",
    \ "SpaceAfterTemplateKeyword": "true",
    \ "SpaceBeforeAssignmentOperators": "true",
    \ "SpacesInAngles": "false",
    \ "SpacesInCStyleCastParentheses": "false",
    \ "SpacesInContainerLiterals": "false",
    \ "SpacesInParentheses": "false",
    \ "AlignOperands": "true",
    \ "IndentWrappedFunctionNames": "true",
    \ "ObjCBinPackProtocolList": "Never",
    \ "AllowShortIfStatementsOnASingleLine": "false",
    \ "AllowShortLoopsOnASingleLine": "false",
    \ "AllowShortFunctionsOnASingleLine": "Inline",
    \ "BinPackArguments": "false"}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" True colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy / paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Doxygen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>D :Dox <CR>
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_colour=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CurtineIncSw, A.vim, ...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F5> :call CurtineIncSw()<CR>
map <F6> :A<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incsearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:incsearch#magic = '\v'
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-table-mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Leader>tm :TableModeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if uname == 'Linux'
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_progname = 'nvr'
endif

let g:polyglot_disabled = ['latex']
let g:vim_markdown_conceal = 0
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:tex_flavor = 'latex'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%] %code%: %s'
let g:ale_linters = {'python': ['flake8']}

nnoremap <Leader>aj :ALENext<CR>
nnoremap <Leader>ak :ALEPrevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline Ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline#ale#indicator_checking = ' '
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_ok = ' '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Signify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:signify_sign_add = '┃' "    
let g:signify_sign_change = '┃' "      
let g:signify_sign_delete = '◢' "    
let g:signify_sign_delete_first_line = '◥'
" let g:gitgutter_sign_modified_removed = '◢'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showtabline=2

let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

let g:lightline_buffer_enable_devicons = 1
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_maxflen = 30

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
    \ 'tabline': {
    \   'left': [['bufferinfo'],
    \            ['separator'],
    \            ['bufferbefore', 'buffercurrent', 'bufferafter']],
    \   'right': [['close']]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'LightlineFugitive',
    \   'readonly': 'LightlineReadonly',
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \   'gutentags': 'gutentags#statusline'
    \ },
    \ 'component_expand': {
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \   'linter_checking': 'left',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'left',
    \ },
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitbranch', 'readonly', 'filename', 'modified']],
    \   'right': [['linter_checking', 'linter_errors',
    \              'linter_warnings', 'linter_ok'],
    \             ['gutentags']],
    \ },
    \ 'separator': {'left': '', 'right': ''},
    \ 'subseparator': {'left': '', 'right': ''}
    \ }

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif

    return ''
endfunction

augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:palenight_terminal_italics=1
let g:lightline.colorscheme = 'palenight'

set background=light
colorscheme palenight

" remove background color (transparent)
hi Normal guibg=NONE ctermfg=None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trailing whitespaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable status line on Neovim for a cleaner look
" if has('nvim') && !exists('g:fzf_layout')
"     autocmd! FileType fzf
"     autocmd  FileType fzf set laststatus=0 noshowmode noruler
"         \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" endif

" Using floating windows of Neovim to start fzf
if has('nvim')
    function! FloatingFZF(width, height, border_highlight)
        function! s:create_float(hl, opts)
          let buf = nvim_create_buf(v:false, v:true)
          let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
          let win = nvim_open_win(buf, v:true, opts)
          call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
          call setwinvar(win, '&colorcolumn', '')
          return buf
        endfunction

    " Size and position
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
    endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }
endif

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

" Add bat shortcuts
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['-m', '--bind', 'ctrl-d:preview-page-down,ctrl-u:preview-page-up', '--preview', '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=numbers --color=always {}) || echo {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, {'options': ['-m', '--bind', 'ctrl-d:preview-page-down,ctrl-u:preview-page-up', '--preview', '([[ -d {} ]] && tree -C {}) || ([[ -f {} ]] && bat --style=numbers --color=always {}) || echo {}']}, <bang>0)
command! -bang -nargs=? -complete=dir Buffers call fzf#vim#buffers(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>f :Files<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>r :Ag<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netatmo"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>fv :Files ${HOME}/work/vision<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Shortuct to select lines"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function Test() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| xclip -sel clipboard')
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically closing brackets parentheses ...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
noremap {;<CR> {<CR>};<ESC>O


" hi Comment ctermfg=LightBlue
