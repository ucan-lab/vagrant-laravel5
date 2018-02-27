set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-vividchalk'
" Plugin 'Lokaltog/vim-powerline' " ステータス表示
Plugin 'scrooloose/nerdcommenter' " , で コメントイン/コメントアウト
Plugin 'css.vim'
Plugin 'php.vim'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'tomtom/tcomment_vim' " https://qiita.com/alpaca_taichou/items/211cd62bee84c59ca480

" https://github.com/plasticboy/vim-markdown
" Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'

" https://github.com/ConradIrwin/vim-bracketed-paste
Plugin 'ConradIrwin/vim-bracketed-paste'

" https://github.com/cocopon/iceberg.vim
Plugin 'cocopon/iceberg.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
nmap ,a <Plug>NERDCommenterAppend
vmap ,p <Plug>NERDCommenterSexy

" let g:Powerline_symbols = 'fancy'

" FuzzyFinder
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_keyOpenSplit = '<CR>'

nnoremap <silent> ff :<C-u>FufFile!<C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> fb :<C-u>FufBuffer!<CR>
nnoremap <silent> fm :<C-u>FufMruFile!<CR>

augroup FufAutoCommand
  autocmd!
  autocmd FileType fuf :imap <buffer> <Tab>   <C-n><C-@>
  autocmd FileType fuf :imap <buffer> <S-Tab> <C-p><C-@>
augroup END

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable
colorscheme iceberg
set term=xterm-256color
set noswapfile

set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start

set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" マウスの有効化
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
