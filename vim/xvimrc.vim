" source ~/.vimrc

set incsearch
set ignorecase
set smartcase		"if mixed characters, perform case sensitive
set hlsearch 
set gdefault 		"substitute all, /g, flag by default is on. /g - now does single substitutions

imap <S-Space> <Esc>
imap <D-S> <Esc>:w<CR>

"inoremap jj <Esc>
"inoremap kk <Esc>

nmap 00 ^
"
" Navigation in insert mode
imap <M-h> <C-Left>
imap <M-l> <C-Right>

nmap S cc

