" FULL VIM
set nocompatible
let s:running_windows = has("win16") || has("win32") || has("win64")

if s:running_windows
	source $VIMRUNTIME/mswin.vim
	behave mswin
	" Don't want vim to reserve ALT key for menu.
	set winaltkeys=no
	set encoding=utf-8
	set fileencodings=ucs-bom,utf-8,latin1
endif

" PATHOGEN
filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on


" Display
set number			"Show line numbers
set numberwidth=3
set cursorline		"Highlight the current line
set showcmd			"Show (partial) command in the last line of the screen.
set ttyfast			"fast terminal connection - improves redrawing smoothness
set listchars=tab:»·,eol:¶,trail:·
set scrolloff=5
set lazyredraw		" Don't redraw the screen while executing macros
set ttyfast
set splitbelow		" splitting a window will put the new window below current
set splitright		" splitting a window will put the new window right of current
set switchbuf=usetab " :sb jumps to the first tab that has the buffer opened

" When included, Vim will use the clipboard register '*'
" for all yank, delete, change and put operations which
" would normally go to the unnamed register.
" Be aware that tmux doesn't play nice with the clipboard on OS X
" http://hynek.me/articles/macvim-and-the-clipboard/
if has('unnamedplus')
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif

" File settings
"if s:running_windows
"	set fileformats=dos
"else
"	set fileformats=unix
"endif

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

" Backup options
set nobackup
set nowritebackup
set autowrite
" When Vim sees that renaming file is possible without side effects (the attributes can be passed on and
" the file is not a link) that is used. When problems are expected, a copy will be made.
set backupcopy=auto

" Set the directory where to save swap files
" Although it's safer to save them in the current directory, I don't like that
" set directory-=.
" My preferred order for .swp files:
if s:running_windows
	set directory=$TEMP,c:\temp,c:\tmp,c:\windows\temp,.
else
	set directory=$TMPDIR,~/tmp,/var/tmp,/tmp,.
endif

"Turn off word wrapping
set nowrap
"set wrap
" Don't autoformat on paste and make it all weird
" paste mode disables map commands. better use it on demand only
" set paste
" Disable the the whole SELECT mode
set selectmode=

" Backspace behavior
set backspace=indent,eol,start

"Indententation
"set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=0
set autoindent
set noexpandtab
set copyindent
set preserveindent
set foldlevelstart=99	"Start with no folds
let g:xml_syntax_folding=1


" Search options
set incsearch
set ignorecase
set smartcase		"if mixed characters, perform case sensitive
set hlsearch
set gdefault 		"substitute all, /g, flag by default is on. /g - now does single substitutions

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t
set wildmenu "Command line completion with menu


" Fancy UI options
"Status line
" set statusline=%f  " Path to file, trim, file name of file in the buffer.
" set statusline+=%F	  " Full path of file
set statusline=%<%{expand('%:p:h')}/%t
set statusline+=%m    " Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
set statusline+=%r    " Readonly flag, text is "[RO]".
set statusline+=%<
set statusline+=\ %=                        " Right align
set statusline+=\ [
if !has("gui")
	set statusline+=b%n: 					"buffer number
endif
set statusline+=%Y:  						" Type of file in the buffer, e.g., ",VIM".
set statusline+=%{&ff}:     				" Type of end-of-line,e.g. "dos" or "unix"
set statusline+=\%{&enc}>%{&fenc}]  		" Encoding and file encoding, e.g. "utf-8"
set statusline+=\ [chr=\%03.3b/0x\%02.2B]  	" Value of byte under cursor (b), and in hex (B)
"set statusline+=\ %=                        " Right align
set statusline+=[%c:%l       			    " Column number and line number
set statusline+=/%L\ %p%%] 			" Percentage through file in lines (p) and number of lines in buffer (L)

set laststatus=2

" Tag files, if present
set tags=./tags,tags

" Enabling the matchit plugin
source $VIMRUNTIME/macros/matchit.vim

"Color scheme
syntax on
"if !has("gui")
"	set t_Co=256
"endif
set background=dark

let g:molokai_original = 0
 
" Solarized
let g:solarized_contrast='normal'  " high, normal, or low   
" let g:solarized_termtrans=0
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
let g:solarized_termcolors=256
" let g:solarized_visibility="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
" let g:solarized_menu=1"

if has('gui')
	if s:running_windows
		"colorscheme vividchalk
		colorscheme solarized
	else
		"colorscheme molokai
		colorscheme solarized
	endif
else
	colorscheme ir_black
endif

"colorscheme solarized


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
"  syntax on
"  set nohlsearch
"endif

" Bash syntax
let g:is_bash=1

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let macvim_hig_shift_movement = 1

set diffopt+=iwhite
"if s:running_windows
	"set diffexpr=MyDiff()
"endif
function! MyDiff()
	let opt = ""
	if &diffopt =~ "icase"
	    let opt = opt . "-i "
	endif
	if &diffopt =~ "iwhite"
	    let opt = opt . "-w "
	endif
	silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new .
				\  " > " . v:fname_out
endfunction
"Session options aka ssop
" set sessionoptions="buffers,curdir,folds,winsize,tabpages"
set sessionoptions=buffers,sesdir,folds,tabpages,winsize

if !exists("autocommands_loaded")
	let autocommands_loaded = 1

	" Resize splits when the window is resized
	" au VimResized * exe "normal! \<c-w>="	

	" autosave when 'losing focus' - ignore unnamed buffers
	au FocusLost,BufLeave * silent! up

	" change to directory of current file automatically
	autocmd BufEnter * lcd %:p:h

	" go into normal mode after saving
	" this is supposed to work, but doesn't quite
	" (allows one more char before exiting insert)
	"au BufWritePost,FocusLost,BufLeave,TabLeave * stopinsert
	" also consider:
	au BufWritePost,FocusLost,BufLeave,TabLeave * call feedkeys("\<C-\>\<C-n>")
	
	" TODO: for terminals with less than 256-colors don't do cursorline on
	" active window - it shows as underline
	augroup highlightcursorline
		"autocmd WinEnter * setlocal nocursorline
		"autocmd WinLeave * setlocal cursorline
	augroup END

	" File mappings
	augroup javascript
		au!
		au BufNewFile,BufRead *.json setl ft=javascript
		"au FileType javascript setl makeprg=jsl\ -conf\ ~/jsl.conf\ -process\ %
		au FileType javascript setl makeprg=node\ %
		au FileType javascript setl fdm=syntax
	augroup END

	au BufNewFile,BufRead *.config setl ft=xml
	au BufNewFile,BufRead *.build setl ft=xml
	au BufNewFile,BufRead *.cshtml setl ft=html
	au BufNewFile,BufRead *.targets setl ft=xml
	au BufNewFile,BufRead *.StyleCop setl ft=xml

	augroup python
		"au FileType python setl makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
		"au FileType python setl efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
		au FileType python setl makeprg=pep8\ --ignore=E501,W191\ --repeat\ %
		au FileType python setl efm=%f:%l:%c:\ %m
		au FileType python setl fdm=indent et ts=4 sw=4
		" au FileType python setl omnifunc=pythoncomplete#Complete
		"au FileType python setl omnifunc=
		

		"au BufRead *.py nmap <F5> :!python %<CR>
		au FileType python nmap <buffer> <leader>2 <Esc>:setl shiftwidth=2 softtabstop=2 expandtab
		au FileType python nmap <buffer> <leader>4 <Esc>:setl shiftwidth=4 softtabstop=4 expandtab
		au FileType python map <buffer> <leader>8 <Esc>:call Flake8()<CR>
	augroup END
	
	augroup xml
		"au FileType xml let g:xml_syntax_folding=1
		au FileType xml setl foldmethod=syntax
		"au FileType xml :syntax on
	augroup END
	
	augroup markdown
		au FileType markdown setl expandtab shiftwidth=4 softtabstop=4
	augroup END

	augroup coffeescript
		au FileType coffee setl foldmethod=indent
		"au BufNewFile,BufReadPost *.coffee setl foldmethod=indent "nofoldenable	
		" To get standard two-space indentation in CoffeeScript files, add this line to your vimrc:
		"au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
	augroup END
	
	" Put these in an autocmd group, so that we can delete them easily.
	"augroup commonfiles
	"	au BufReadPre,BufNewFile
	"	\ *.xsl,*.xml,*.css,*.html,*.js,*.php,*.sql,*.sh,*.conf,*.cc,*.cpp,*.h
	"	\  setl smartindent shiftwidth=2 softtabstop=2 expandtab
	"
	"	au BufReadPre,BufNewFile
	"	\ *.tex
	"	\ setl wrap shiftwidth=2 softtabstop=2 expandtab
	"augroup END

endif


" <Esc> is too far, and <C-[> and <C-c> is too complicated on OSX
"inoremap <S-Space> <Esc>
if s:running_windows
	"inoremap <C-Space> <Esc>
	"inoremap <C-S-Space> <C-o>
	unmap <C-Y>
	"In 7.3 <C-S> is mapped to <C-O>:update<CR>
	" which causes problems when C-S is pressed after <C-X><C-O>
	" https://groups.google.com/forum/?fromgroups#!topic/vim_use/GhjXF1S6aNQ
	" alas this doesn't quite work well with set paste in insert mode
	" inoremap <C-S> <C-\><C-O>:update<CR>
	inoremap <C-S> <Esc>:update<CR>a
else
	"inoremap <D-Space> <Esc>
	"inoremap <D-S-Space> <C-o>
endif

" Don't use Ex mode, use Q for formatting
noremap Q gq

" map jj to esc as a way to get out of insert easy
inoremap jj <Esc>
inoremap kk <Esc>

" the way vim jumps over wrapped text is annoying
noremap j gj
noremap k gk

" map C-A to home, C-E to end
inoremap <C-A> <Esc>I
inoremap <C-E> <Esc>A

" ^ is too hard to reach, 0 is easier
nnoremap 00 ^

" Finer undo control - on every word
inoremap <Space> <Space><C-g>u

" # in insert mode will put it on the first line
" http://vim.wikia.com/wiki/Restoring_indent_after_typing_hash
inoremap # x<BS>#

" Hide search highlighting
noremap <Leader>l :set invhls <CR>

" pull word under cursor into lhs of a substitute (for quick search and replace)
nnoremap <leader>r :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" When pressing <leader>cd switch to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>

" Duplicate a selection
" Visual mode: D
" vnoremap D y']P
" nnoremap D yyp

" yank normally moves the cursor to the beginning of the selection
" this leaves the cursor at the current position
vnoremap y y']

" No Help, please
nnoremap <F1> <Esc>

" highlight the current word without searching
nnoremap <Leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Window navigation
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
noremap ]cc :botright cope<cr>
noremap [cc :ccl<cr>
noremap ]e :cn<cr>
noremap [e :cp<cr>

" Toggle wrapping
if s:running_windows
	noremap <M-w> :set nowrap! <CR>
else
	noremap <A-w> :set nowrap! <CR>
endif

" Tab is indent
" nnoremap <Tab> >>
" nnoremap <S-Tab> <<

" Tab keys - mswin.vim sets Ctrl-Tab to switch windows
if s:running_windows
	"noremap <C-Tab> <C-W>w
	"inoremap <C-Tab> <C-O><C-W>w
	"cnoremap <C-Tab> <C-C><C-W>w
	"onoremap <C-Tab> <C-C><C-W>w
	noremap <C-Tab> :tabnext <CR>
	inoremap <C-Tab> <C-O>:tabnext <CR>
	cnoremap <C-Tab> <C-C>:tabnext <CR>
	onoremap <C-Tab> <C-C>:tabnext <CR>
	noremap <C-S-Tab> :tabprev <CR>
	inoremap <C-S-Tab> <C-O>:tabprev <CR>
	cnoremap <C-S-Tab> <C-C>:tabprev <CR>
	onoremap <C-S-Tab> <C-C>:tabprev <CR>
	nnoremap <C-T> :tabnew<CR>
	inoremap <M-Del> <Esc>lce
	inoremap <C-Del> <Esc>lc$
	inoremap <M-BS>  <C-W>
	inoremap <C-BS>  <C-U>
endif

" Alt-Delete in insert mode
noremap <D-Del> <Esc>d$a
noremap <M-Del> <Esc>dea
" Moves one right because when pressing <Esc> the block cursor gets placed on
" the char left of the insert cursor.
inoremap <D-Del> <Esc>lc$
inoremap <M-Del> <Esc>lce

" Run make
inoremap <F5> <C-O>:make <CR>
nnoremap <F5> :make <CR>

" fix Vim’s horribly broken default regex “handling”
" by automatically inserting a \v before any string you search for.
" This turns off Vim’s crazy default regex characters
" and makes searches use normal regexes.
nnoremap / /\v
vnoremap / /\v

" When searching use ,n to select the match, not just highlight them.
nnoremap <Leader>n //b<CR>v//e<CR>

" More complex versions:
"nnoremap ,n /<C-R>//b<CR>ma/<C-R>//e<CR>mb`av`b
"vnoremap ,n <ESC>/<C-R>//b<CR>ma/<C-R>//e<CR>mb`av`b

" Split windows and move into the next (right) window
nnoremap <Leader>w <C-w>v<C-w>l

" Toggles invisible characters
nnoremap <Leader>h :set invlist<CR>

" Navigation in insert mode
inoremap <M-h> <C-Left>
inoremap <M-l> <C-Right>

" turn spell-check on/off
noremap <F7>   <Esc>:setlocal spell spelllang=en_us<CR>
noremap <S-F7> <Esc>:set nospell<CR>
set spellfile=~/.vim/my.en.utf-8.add
set spellsuggest=best,10

" delete matching brackets
" deletes the parenthesis
nnoremap <Leader>% %x``x
" replaces matching brackets with spaces
nnoremap <Leader>%<Space> %r<Space>``.

" Close all folds
nnoremap <Leader>z <Esc>:%foldc!

" Shortcut for ls followed by mapping buffer
nnoremap <Leader><Leader> :ls<CR>:b<Space><Space><BS>
nnoremap <Leader><Tab> :ls<CR>:sb<Space><Space><BS>

" Remove spaces at the end of line
" while it works, it also sets the \s+$ as the search criterion
nnoremap <Leader><Space>$ :%s/\s\+$//<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
"show on right
let NERDTreeWinPost="right"
" store the bookmarks file
" let NERDTreeBookmarksFile=expand("$HOME/.vim/.tmp/NERDTreeBookmarks")
" show hidden files, too
" let NERDTreeShowHidden=1
" highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2
" automatically CWD to root node
let NERDTreeChDirMode=2
" close NERDTree after file is opened
"let NERDTreeQuitOnOpen=1
" don't display these kinds of files
let NERDTreeIgnore=[ '^\.git$','^\.svn$','^\.DS_Store$','^\.[\w\.]+\.swp$','\.pyc$' ]

" NERDCommenter
let NERDSpaceDelims=1

" Zen Coding transitioning to Emmet
" Use C-K instead of C-Y, it's more convenient
let g:user_zen_leader_key = '<C-k>'
let g:user_emmet_leader_key = '<C-k>'
" complete tags using omnifunc
let g:use_zen_complete_tag = 1
let g:use_emmet_complete_tag = 1

" Supertab
let g:SuperTabDefaultCompletionType = "context"

"if !exists("autocommands_loaded")
	" putting SuperTab in chaining mode:
	" https://github.com/ervandew/supertab/issues/52
	autocmd FileType *
		\ if &omnifunc != '' |
		\ 	call SuperTabChain(&omnifunc, "<c-p>") |
		\ endif
"endif

" Jedi-vim
let g:jedi#popup_on_dot = 0

" vim-coffee-script
" Disable trailing whitespace error
hi link coffeeSpaceError NONE

let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript-jquery'


" flake8 - pyflakes + pep8
"let g:pep8_map='<leader>8'
let g:flake8_max_line_length=120
" PEP8 ignores:
"   E501 - line too long
"   E701 - multiple statements on one line (colon)
"   W391 - blank line at the end of file
"   W404 - from module import * warning
let g:flake8_ignore="E701,W391"

" ignores for Ctrl-P
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|pyc)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! JavaScriptFold()
"    setl foldmethod=syntax
"    setl foldlevelstart=1
"    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"    function! FoldText()
"    return substitute(getline(v:foldstart), '{.*', '{...}', '')
"    endfunction
"    setl foldtext=FoldText()
"endfunction

" Vertical Split Buffer Function
function! VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer
endfunction
" Vertical Split Buffer Mapping
command! -nargs=1 Vsb call VerticalSplitBuffer(<f-args>)


" Removes spaces
function! ShowSpaces(...)
	let @/='\v(\s+$)|( +\ze\t)'
	let oldhlsearch=&hlsearch
	if !a:0
		let &hlsearch=!&hlsearch
	else
		let &hlsearch=a:1
	end
	return oldhlsearch
endfunction

function! TrimSpaces() range
	let oldhlsearch=ShowSpaces(1)
	execute a:firstline.",".a:lastline."substitute ///gec"
	let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
"nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <Leader><Space>$   m`:TrimSpaces<CR>``
vnoremap <Leader><Space>$   :TrimSpaces<CR>


" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
