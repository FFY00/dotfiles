set encoding=utf-8 nobomb " Set encoding

" Plugin Autoinstall - Run PlugInstall if any plugin is missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent ! curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" Dependencies
Plug 'rbgrouleff/bclose.vim'

" Plugins
Plug 'vim-airline/vim-airline'		" Airline - Status Bar
Plug 'vim-airline/vim-airline-themes'	" Themes for Airline
Plug 't1mxg0d/vim-lucario'		" Lucario colorscheme
Plug 'itspriddle/vim-shellcheck'	" Shellcheck wrapper
Plug 'dag/vim-fish'			" Fish shell function/script support
Plug 'othree/html5.vim'			" HTML5 support
Plug 'lilydjwg/colorizer'		" Add color to #556677 or rag(50, 100, 200) tags
Plug 'cohama/lexima.vim'		" Autoclose parentheses, quotes, etc.
Plug 'terryma/vim-multiple-cursors'	" Multiple cursors
Plug 'martin-svk/vim-yaml'		" YAML support
Plug 'tpope/vim-markdown'		" Markdown support
Plug 'tpope/vim-git'			" Git support
Plug 'airblade/vim-gitgutter'		" Shows git differences when editing the file
Plug 'RRethy/vim-illuminate'		" Highlights other ocurrences of the word bellow the cursor:h
Plug 'ryanoasis/vim-devicons'		" Adds icons
Plug 'honza/dockerfile.vim'		" Docker support
Plug 'bogado/file-line'			" Allows vim/nvim file.txt:20 where 20 is the line number
Plug 'francoiscabrol/ranger.vim'	" Ranger integration
Plug 'JesseKPhillips/d.vim'		" Dlang syntax
Plug 'idanarye/vim-dutyl'		" Dlang tools integration
Plug 'tbastos/vim-lua'			" Lua support
Plug 'matze/vim-meson'			" Meson support

" Reminder: Run PlugInstall after adding new plugins

call plug#end()

" Custom
syntax enable		" Enable syntax
set number		" Show line numbers
colorscheme lucario	" Set colorscheme
set mouse-=a		" Disable mouse integration
set pastetoggle=<F2>	" Map F2 to toggle paste mode

" Show tabs, whitespaces, etc.
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪

filetype plugin on
filetype indent on

" Plugin configs

" Set syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Set ranger keys
let g:ranger_map_keys = 0
map <F3> :Ranger<CR>
let g:ranger_replace_netrw = 1

" Airline

let g:airline_theme='jellybeans'	" Set Airline theme
set noshowmode				" Hide -- MODE --

" Set symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
