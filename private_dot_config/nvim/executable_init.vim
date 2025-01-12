set encoding=utf-8 nobomb " Set encoding

" Plugin Autoinstall - Run PlugInstall if any plugin is missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent ! curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

"
" Plugins
"

" Dependencies
Plug 'rbgrouleff/bclose.vim'

" Theme
Plug 'vim-airline/vim-airline'		" Airline - Status Bar
Plug 'vim-airline/vim-airline-themes'	" Themes for Airline
Plug 'raphamorim/lucario'		" Lucario colorscheme
Plug 'ryanoasis/vim-devicons'		" Adds icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}	" Treesitter syntax highlighting

" Custom funcionality
Plug 'tpope/vim-sleuth'			" Automatically adapt to current indentation
Plug 'bogado/file-line'			" Allows vim/nvim file.txt:20 where 20 is the line number
Plug 'RRethy/vim-illuminate'		" Highlights other ocurrences of the word bellow the cursor:h
Plug 'norcalli/nvim-colorizer.lua'	" Add color to #556677 or rbg(50, 100, 200) tags
Plug 'airblade/vim-gitgutter'		" Shows git differences when editing the file
Plug 'Raimondi/delimitMate'		" Autoclose parentheses, quotes, etc.
Plug 'jamessan/vim-gnupg'		" Transparent editing of GPG files
Plug 'terryma/vim-multiple-cursors'	" Multiple cursors
Plug 'Houl/repmo-vim'			" Allow to repeat motions
Plug 'dstein64/vim-startuptime'		" Debug startup time

" Tool support
Plug 'tpope/vim-git'			" Git support
Plug 'francoiscabrol/ranger.vim'	" Ranger integration
Plug 'idanarye/vim-dutyl'		" Dlang tools integration

" Language/syntax support
Plug 'itspriddle/vim-shellcheck'	" Shellcheck wrapper
Plug 'dag/vim-fish'			" Fish shell function/script support
Plug 'othree/html5.vim'			" HTML5 support
Plug 'martin-svk/vim-yaml'		" YAML support
Plug 'tpope/vim-markdown'		" Markdown support
Plug 'honza/dockerfile.vim'		" Docker support
Plug 'JesseKPhillips/d.vim'		" Dlang syntax
Plug 'tbastos/vim-lua'			" Lua support
Plug 'matze/vim-meson'			" Meson support
Plug 'pearofducks/ansible-vim'		" Ansible support
Plug 'cespare/vim-toml'			" TOML support

" Language servers
"Plug 'davidhalter/jedi-vim'		" Python autocomplete

" Service support
Plug 'wakatime/vim-wakatime'		" Wakatime

" Reminder: Run PlugInstall after adding new plugins

call plug#end()

" Disable system-wide plugins
let g:load_black=1

"
" Native config
"

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'python', 'c', 'bash' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        -- Disable languages
        for i, value in pairs({ 'git_rebase' }) do
          if string.match(lang, value) then
            return true
          end
        end
        -- Disable highlighting on large files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  }
}
EOF

" Alias
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :q!

" Custom
syntax enable			" Enable syntax
set number relativenumber	" Show line numbers
colorscheme lucario		" Set colorscheme
set mouse=			" Disable mouse integration
set pastetoggle=<F2>		" Map F2 to toggle paste mode
set termguicolors		" Enable 24-bit colors (needed for colorizer)

" Enable file type detection and type-based indent settings
filetype on
filetype indent on

" Disable highlighting on large files
autocmd Filetype * if getfsize(@%) > 100 * 1024 | setlocal syntax=OFF | endif

" Disable background color to make honor transparency
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

" Show tabs, whitespaces, etc.
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪

"
" Plugin configs
"

" Colorizer

lua require'colorizer'.setup()

" Airline
let g:airline_theme='jellybeans'	" Set Airline theme
set noshowmode				" Hide -- MODE --

" Set symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
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
"let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" Set syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Set ranger keys
let g:ranger_map_keys = 0
map <F3> :Ranger<CR>
let g:ranger_replace_netrw = 1

" repmo.vim
" motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

" if you like `:noremap j gj', you can keep that:
:map <expr> j repmo#Key('gj', 'gk')|sunmap j
:map <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> , repmo#LastRevKey(',')|sunmap ,

" add these mappings when repeating with `;' or `,':
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T
