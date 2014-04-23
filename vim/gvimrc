set numberwidth=5

" Supplement to .vimrc
let s:running_windows = has("win16") || has("win32") || has("win64")
if has("gui_macvim")
	" Enable shortcuts using the Alt/Option/Meta key on the Mac
	set macmeta
endif

" gVim does well in paste mode
set nopaste
set cursorline		"Highlight the current line

" GUI has enough space to start in vertical mode
set diffopt+=vertical

augroup highlightcursorline
	" remove the toggling on the cursorline that is set in .vimrc
	au!
augroup END

if &l:diff
	set guifont=Menlo:h8
else
	set guifont=Menlo:h12
endif
"set guifont=Monaco:h11
if s:running_windows
	"set guifont=Consolas:h10
	if &l:diff
		set guifont=Dina:h8
	else
		"set guifont=Monaco:h8
		set guifont=Consolas:h10
	endif
	"set guifont=Monaco:h8:w6
	"set guifont=Anonymous_Pro:h11
	"set guifont=Dina:h9
	set guioptions-=t   " No tear-off menu entries
	set lines=50
	set columns=180
endif

set guioptions-=T  " No toolbar
set showtabline=2  " Always show the tab pages

" set up tab tooltips with every buffer name
function! GuiTabToolTip()
	let tip = ''
	let bufnrlist = tabpagebuflist(v:lnum)
	for bufnr in bufnrlist
		" separate buffer entries
		if tip!=''
  			let tip .= " \n"
		endif
		" Add name of buffer
		let name=bufname(bufnr)
		if name == ''
  			" give a name to no name documents
  			if getbufvar(bufnr,'&buftype')=='quickfix'
    			let name = '[Quickfix List]'
  			else
    			let name = '[No Name]'
  			endif
		endif
		let tip.=bufnr . ': ' . name
		" add modified/modifiable flags
		if getbufvar(bufnr, "&modified")
  			let tip .= ' [+]'
		endif
		if getbufvar(bufnr, "&modifiable")==0
  			let tip .= ' [-]'
		endif
	endfor
	return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  	let label = ''
  	let bufnrlist = tabpagebuflist(v:lnum)
  	" Add '+' if one of the buffers in the tab page is modified
  	for bufnr in bufnrlist
    	if getbufvar(bufnr, "&modified")
      		let label = '+'
      		break
    	endif
  	endfor
  	" Append the tab number
  	" let label .= v:lnum.': '
  	" Append the buffer name
  	let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  	if name == ''
    	" give a name to no-name documents
    	if &buftype=='quickfix'
      		let name = '[Quickfix List]'
    	else
      		let name = '[No Name]'
    	endif
  	else
    	" get only the file name
    	let name = fnamemodify(name,":t")
  	endif
  	let label .= name
  	" Append the number of windows in the tab page
  	let wincount = tabpagewinnr(v:lnum, '$')
  	return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

" Disable the print key which I keep hitting instead of Ctrl-P
macmenu File.Print key=<nop>
nmap <D-p> <C-p>
