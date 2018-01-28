"
" Vundle - START
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

"
" Vundle - END
"

" Custom
syntax enable
set number
colorscheme lucario
set mouse-=a

" Force Backspace
set backspace=indent,eol,start
