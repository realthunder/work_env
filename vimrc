set nocompatible

silent! call mkdir ($HOME.'/.vim/backup', 'p')
silent! call mkdir ($HOME.'/.vim/swap', 'p')
silent! call mkdir ($HOME.'/.vim/undo', 'p')
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

set runtimepath+=$HOME/.vim/bundle/vundle/
runtime autoload/vundle.vim

if exists( '*vundle#begin' )

  filetype off
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'

  "git interface
  Plugin 'tpope/vim-fugitive'
  Plugin 'L9'
  "filesystem
  Plugin 'scrooloose/nerdtree'
  " Plugin 'jistr/vim-nerdtree-tabs'
  Plugin 'ctrlpvim/ctrlp.vim' 
  " Plugin 'JazzCore/ctrlp-cmatcher'

  " Commenter
  Plugin 'scrooloose/nerdcommenter'

  "html
  "  isnowfy only compatible with python not python3
  Plugin 'isnowfy/python-vim-instant-markdown'
  Plugin 'jtratner/vim-flavored-markdown'
  Plugin 'suan/vim-instant-markdown'
  Plugin 'nelstrom/vim-markdown-preview'
  "python sytax checker
  " Plugin 'nvie/vim-flake8'
  " Plugin 'vim-scripts/Pydiction'
  " Plugin 'vim-scripts/indentpython.vim'
  Plugin 'scrooloose/syntastic'

  "auto-completion stuff
  "Plugin 'klen/python-mode'
  Plugin 'Valloric/YouCompleteMe'
  "Plugin 'klen/rope-vim'
  " Plugin 'davidhalter/jedi-vim'
  " Plugin 'ervandew/supertab'
  ""code folding
  Plugin 'tmhedberg/SimpylFold'

  "Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'

  "Plugin 'vim-scripts/FuzzyFinder'

  Plugin 'majutsushi/tagbar'

  "Colors!!!
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'jnurmine/Zenburn'

  Plugin 'vim-scripts/Conque-GDB'

  call vundle#end()

endif

command  InstallVundle
\ if ! InstallVundle()                                                            |
\   echohl ErrorMsg                                                               |
\   echomsg 'Failed to install Vundle automatically. Please install it yourself.' |
\   echohl None                                                                   |
\ endif
function InstallVundle()
  let vundle_repo = 'https://github.com/gmarik/vundle.git'
  let path = substitute( $HOME . '/.vim/bundle/vundle', '/', has( 'win32' ) ? '\\' : '/', 'g' )
  if ! executable( 'git' )
    echohl ErrorMsg | echomsg 'Git is not available.' | echohl None | return 0
  endif
  if ! isdirectory( path )
    silent! if ! mkdir( path, 'p' )
      echohl ErrorMsg | echomsg 'Cannot create directory (may be a regular file): ' . path | echohl None | return 0
    endif
  endif
  echo 'Cloning vundle...'
  if system( 'git clone "' . vundle_repo . '" "' . path . '"'  ) =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . vundle_repo . ' (' . path . ' may be not empty)' | echohl None | return 0
  endif
  echo 'Vundle installed. Please restart vim and run :PluginInstall'
  return 1
endfunction

filetype plugin indent on

set fileencodings=ucs-bom,utf-8,gbk,latin1
fixdel

set clipboard=unnamed

let mapleader=","

let g:SimpylFold_docstring_preview = 1

" YCM
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion = 1
map <leader>y  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
call togglebg#map("<F5>")

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"turn on numbering
set number

"python with virtualenv support
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=80

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

"Folding based on indentation:
autocmd FileType python set foldmethod=indent
"use space to open folds
nnoremap <space> za 
"----------Stop python PEP 8 stuff--------------

"js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

"set ruler           " displays the 'ruler' at the bottom-right of the screen
"set nowrap          " no line wrapping;
set guioptions+=b   " add a horizontal scrollbar to the bottom
set autowrite
set hidden

"--- search options ------------
set incsearch       " show 'best match so far' as you type
set hlsearch        " hilight the items found by the search
set ignorecase      " ignores case of letters on searches
set smartcase       " Override the 'ignorecase' option if the search pattern contains upper case characters
":highlight search guifg=yellow guibg=darkred

"--- indentation ---------------
set expandtab
set smarttab
"set smartindent    " smart indent of code - indent after opening '{',
"set cindent
filetype plugin indent on

"set autoindent     " Copy indent from current line when starting a new line
set shiftwidth=4   " Number of spaces to use for each step of (auto)indent (used for the >>, << commands)
set tabstop=4      " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4  " Backspace the proper number of spaces
set shiftround     " Round indent to multiple of 'shiftwidth'

" comments are not placed in the first column.  They stay at their current indent level
"inoremap # #

"--- Keystrokes ----------------
" h and l wrap between lines, cursor keys wrap in insertion mode
"set whichwrap=h,l,~,[,]

" page down with <SPACE>, pageup with - or <BkSpc>
"noremap <Space> <PageDown>
"noremap <BS> <PageUp>

" allow <BkSpc> to delete line breaks, start of insertion, and indents
set backspace=eol,start,indent

" to explicitly enter the <del> key, in insert mode, press <C-v> and then <Del>
set <Del>=[3~

set wmh=0   "set other opened files to just show filename

" Swap ; and :  Convenient.
"nnoremap ; :
"nnoremap : ;

" use ctrl-h/j/k/l to switch between splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
set wildmenu

"-- always set cwd to current buffer ---
" * helps a lot with multiple windows
function! CHANGE_CURR_DIR()
  let _dir = expand("%:p:h")
  exec "cd " . _dir
  unlet _dir
endfunction

"-- open file at the last position ---
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"autocmd BufEnter * call CHANGE_CURR_DIR()
"---------------------------------------

set makeprg=~/make.sh

colorscheme zenburn
highlight String ctermbg=1
highlight Search ctermfg=blue
" matching bracket pattern
highlight MatchParen cterm=bold ctermbg=black ctermfg=green

" fuzzy finder shutcut
" nnoremap ,fb :FuzzyFinderBuffer<CR>
" nnoremap ,fdb :FuzzyFinderDirWithCurrentBufferDir<CR>
" nnoremap ,fdd :FuzzyFinderDir<CR>
" nnoremap ,fdc :FuzzyFinderDirWithFullCwd<CR>
" nnoremap ,fff :FuzzyFinderFile<CR>
" nnoremap ,ffb :FuzzyFinderFileWithCurrentBufferDir<CR>
" nnoremap ,ffc :FuzzyFinderFileWithFullCwd<CR>

" " netrw stuffs
" function! ToggleVExplorer()
"     if exists("t:expl_buf_num")
"         let expl_win_num = bufwinnr(t:expl_buf_num)
"         if expl_win_num != -1
"             let cur_win_nr = winnr()
"             exec expl_win_num . 'wincmd w'
"             close
"             exec cur_win_nr . 'wincmd w'
"             unlet t:expl_buf_num
"         else
"             unlet t:expl_buf_num
"         endif
"     else
"         exec '1wincmd w'
"         Vexplore
"         let t:expl_buf_num = bufnr("%")
"     endif
" endfunction
"
" nnoremap ,en :call ToggleVExplorer()<CR>
"
" com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)
"
" fun! Lexplore(dir, right)
"   if exists("t:netrw_lexbufnr")
"   " close down netrw explorer window
"   let lexwinnr = bufwinnr(t:netrw_lexbufnr)
"   if lexwinnr != -1
"     let curwin = winnr()
"     exe lexwinnr."wincmd w"
"     close
"     exe curwin."wincmd w"
"   endif
"   unlet t:netrw_lexbufnr
"
"   else
"     " open netrw explorer window in the dir of current file
"     " (even on remote files)
"     let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
"     exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
"     if a:dir != ""
"       exe "Explore ".a:dir
"     else
"       exe "Explore ".path
"     endif
"     setlocal winfixwidth
"     let t:netrw_lexbufnr = bufnr("%")
"   endif
" endfun
"
" " absolute width of netrw window
" let g:netrw_winsize = -28
"
" " do not display info on the top of window
" let g:netrw_banner = 0
"
" " tree-view
" let g:netrw_liststyle = 3
"
" " sort is affecting only: directories on the top, files below
" let g:netrw_sort_sequence = '[\/]$,*'
"
" " use the previous window to open file
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
"
" let g:netrw_list_hide= '.*\.swp$'
"
" " follow symlinked file
" function! FollowSymlink()
"   let current_file = expand('%:p')
"   " check if file type is a symlink
"   if getftype(current_file) == 'link'
"     " if it is a symlink resolve to the actual file path
"     "   and open the actual file
"     let actual_file = resolve(current_file)
"     silent! execute 'file ' . actual_file
"   end
" endfunction
"
" " follow symlink
" autocmd BufRead *  call FollowSymlink()
"
" " netrw: follow symlink
" autocmd CursorMoved *
"   " short circuit for non-netrw files
"   \ if &filetype == 'netrw' |
"   \   call FollowSymlink() |
"   \ endif
"

" NERD tree
"
nnoremap <leader>nn :NERDTree <CR>
nnoremap <leader>nc :NERDTreeClose <CR>
nnoremap <leader>nt :NERDTreeToggle <CR>
nnoremap <leader>nd :call DisableNERDTree()<CR>:e .<CR>
nnoremap <leader>ne :call HijackNERTW()<CR>:e .<CR>

" taglist shutcut
" nnoremap ,tt :TlistToggle<CR>
" nnoremap ,to :TlistOpen<CR>

" tagbar
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>to :TagbarOpen fj<CR>

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zk o<Esc>
nnoremap <silent> zj O<Esc>

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
cmap jj <C-c>

" Quickfix shutcut
nnoremap <leader>qn :cn<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qp :cp<CR>

" Comment shutcut
"noremap <silent> ,# :call CommentLineToEnd('# ')<CR>+
"noremap <silent> ;# :call CommentLineToEnd('### ')<CR>+
"noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
"noremap <silent> ," :call CommentLineToEnd('" ')<CR>+
"noremap <silent> ,; :call CommentLineToEnd('; ')<CR>+
"noremap <silent> ,- :call CommentLineToEnd('-- ')<CR>+
"noremap <silent> ,* :call CommentLinePincer('/* ', ' */')<CR>+
"noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

" NERD commenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" cd to current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" :let g:vimim_cloud = 'google,sogou,baidu,qq'  
:let g:vimim_cloud = 'google'  
:let g:vimim_map = 'tab_as_gi'  
" :let g:vimim_mode = 'dynamic'  
" :let g:vimim_mycloud = 0  
" :let g:vimim_plugin = 'C:/var/mobile/vim/vimfiles/plugin'  
" :let g:vimim_punctuation = 2  
" :let g:vimim_shuangpin = 0  
" :let g:vimim_toggle = 'pinyin,google,sogou' 
"

" CtrlP
let g:ctrlp_follow_symlinks=1
let g:ctrlp_match_window = 'results:100'
nnoremap <leader>fb :CtrlPBuffer<CR>
nnoremap <leader>fp :CtrlP<Space>
nnoremap <leader>fm :CtrlPMixed<CR>
nnoremap <leader>ff :CtrlPCurWD<CR>
nnoremap <leader>ft :CtrlPTag<CR>
nnoremap <leader>fg :CtrlPBufTag<CR>

" The Silver Searcher
" apt-get install silversearcher-ag
if executable('ag')

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

	" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
	"                         \ --ignore .git
	"                         \ --ignore .svn
	"                         \ --ignore .hg
	"                         \ --ignore .DS_Store
	"                         \ --ignore "**/*.pyc"
	"                         \ -g ""'
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
    let g:ctrlp_by_filename = 1
	" let g:ctrlp_working_path_mode = 0
	" let g:ctrlp_switch_buffer = 0
    let g:ctrlp_extensions = ['buffertag', 'tag', 'line']
    " let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
endif
" grep word under cursor
nnoremap <leader>fw :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit -v -a<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gdiff<Space>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" diff mode
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dn [c
nnoremap <leader>do ]c

" for airline
set laststatus=2
" let g:airline#extensions#tabline#fnamemod = ":~:."
let g:airline#extensions#tabline#fnamemod = ":t"


if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" auto reload .vimrc change
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
