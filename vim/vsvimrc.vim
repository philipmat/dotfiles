" source c:\users\pmateescu\vimfiles\vimrc
source ~/vimfiles/vimrc

" VsVim picks weird colors for BG that don't work well with dark themes?
set nocursorline
" This project likes to use spaces
set et
iunmap <Space>
" unmap /
unmap <C-Tab>
unmap <C-S-Tab>

" nmap <C-T> :vsc Edit.NavigateTo<CR>
imap <C-j> <CR>
imap <C-s> <Esc>:w<CR>
nmap <C-s> :w<CR>
nmap <C-z> u
imap <C-z> <Esc>u
nmap <C-]> :vsc Edit.GoToDefinition<CR>
nmap gd :vsc Edit.GoToDefinition<CR>
nmap <C-O> :vsc View.NavigateBackward<CR>
nmap <C-I> :vsc View.NagivateForward<CR>
nmap <C-W>q :close<CR>
nmap <Space> <C-D>
nmap <S-Space> <C-U>

" when VsVim implements let
" puts the three-line /// <summary> on a single line
" let @s=ddkJ5xi
"

" mswin.vim behavior:
" copied from Vim 7.3's mswin.vim:

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

imap <C-V>		<Esc>"+gpa

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

"exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
"exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <C-V> <Esc>:vsc Edit.Paste<CR>gi

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>


" CTRL-A is Select all
"noremap <C-A> gggH<C-O>G
noremap <C-A> ggVGl


" collapse comments
let @r="kJJT>dt<i"
