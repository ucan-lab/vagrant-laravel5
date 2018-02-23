set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" https://github.com/plasticboy/vim-markdown
" Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'

" https://github.com/ConradIrwin/vim-bracketed-paste
Plugin 'ConradIrwin/vim-bracketed-paste'

" https://github.com/cocopon/iceberg.vim
Plugin 'cocopon/iceberg.vim'
call vundle#end()

" Setting
syntax enable
colorscheme iceberg
set term=xterm-256color
set noswapfile
