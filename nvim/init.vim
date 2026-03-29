call plug#begin('~/.config/nvim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

Plug 'phaazon/hop.nvim'

" fzf native plugin
Plug 'junegunn/fzf'
" fzf.vim
Plug 'junegunn/fzf.vim'

" rainbow brackets
Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'

" colorschemes
Plug 'https://github.com/ellisonleao/gruvbox.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-vividchalk'
Plug 'junegunn/seoul256.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'folke/tokyonight.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Show which keys are registered
Plug 'folke/which-key.nvim'

" Initialize plugin system
call plug#end()


let s:running_windows = has("win16") || has("win32") || has("win64")

if s:running_windows
    source ~/vimfiles/vimrc
else
    source ~/.vim/vimrc
endif

set nocompatible
if (has("termguicolors"))
    set termguicolors

	set background=dark
	syntax enable
	color nord
	
	" Ayu
	" let ayucolor="light"  " for light version of theme
	" let ayucolor="mirage" " for mirage version of theme
	" let ayucolor="dark"   " for dark version of theme
	" colorscheme ayu

	" color nightfox " dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox

	" colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

	"colorscheme tokyonight
	" There are also colorschemes for the different styles.
	" colorscheme tokyonight-night
	" colorscheme tokyonight-storm
	" colorscheme tokyonight-day
	" colorscheme tokyonight-moon
else
	colo evening
endif 

lua require('config')
"lua << EOF
"require'hop'.setup()
"EOF
