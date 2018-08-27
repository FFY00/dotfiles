set encoding=utf-8 nobomb

" Neovim Config
let mapleader=","

" Autoinstall
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent ! curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'benekastah/neomake', {'on': ['Neomake'] }
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'jasoncodes/ctrlp-modified.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx' | Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'sheerun/vim-json'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xhtml', 'javascript', 'javascript.jsx'] }
Plug 'martin-svk/vim-yaml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentline'
Plug 'Raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'honza/dockerfile.vim'
Plug 'majutsushi/tagbar'
Plug 'garyburd/go-explorer'
Plug 'fatih/vim-go'

call plug#end()

" Custom
syntax enable
set number
colorscheme lucario
set mouse-=a

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪

filetype plugin on
filetype indent on

set foldmethod=marker
set foldlevel=2
set fillchars="fold: "

set cmdheight=1
set completeopt-=preview
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=tmp/**
set wildmenu
set wildmode=list:longest
set completeopt=menu,menuone
set confirm
set linespace=3
set laststatus=2

let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=50
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0
let g:NERDTreeRespectWildIgnore=1

let g:gitgutter_map_keys=0
let g:gitgutter_max_signs=9999
let g:gitgutter_sign_added='+'
let g:gitgutter_sign_modified='~'
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_modified_removed='~'
let g:gitgutter_sign_removed_first_line='-'

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:jsx_ext_required=0

let g:neomake_verbose=0
let g:neomake_warning_sign = {
      \ 'text': '❯',
      \ 'texthl': 'WarningMsg',
      \ }
let g:neomake_error_sign = {
      \ 'text': '❯',
      \ 'texthl': 'ErrorMsg',
      \ }

let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_folding_disabled=1

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python3_host_skip_check=1

let g:deoplete#enable_at_startup=1

let g:markdown_fenced_languages=[
      \'bash=sh',
      \'git=gitconfig',
      \'javascript',
      \'lua',
      \'ruby',
      \'tmux',
      \'viml=vim',
      \'xdefaults',
      \'zsh']
