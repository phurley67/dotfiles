filetype off                  " required!
let $PATH='/usr/local/bin:'.$PATH

if has('python3')
  silent! python3 1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'elmcast/elm-vim'
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-vividchalk'
Plugin 'scrooloose/nerdcommenter'
Plugin 'gabesoft/vim-ags'
Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-lua-ftplugin'

" Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'

Plugin 'valloric/youcompleteme'

Plugin 'pangloss/vim-javascript'
" Remember leader leader (,,)
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/fzf.vim'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tmhedberg/matchit'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-haml'
Plugin 'rizzatti/dash.vim'
Plugin 'mustache/vim-mustache-handlebars'

Plugin 'vhdirk/vim-cmake'
Plugin 'prettier/vim-prettier'

Plugin 'kchmck/vim-coffee-script'
Plugin 'ollykel/v-vim'
Plugin 'vim-crystal/vim-crystal'

call vundle#end()            " required
filetype plugin indent on    " required

" If installed using Homebrew
set rtp+=/opt/homebrew/opt/fzf


":set filetype=json
:syntax on
:set foldmethod=syntax
:set foldlevelstart=20

autocmd Syntax c,cpp,vim,xml.html.xhtml,perl,ruby,java,javascript normal zR

colorscheme vividchalk

if has("gui_macvim")
    set guioptions=egmrt
    " set guifont=Inconsolata-dz:h22
    " set guifont=Monaco\ for\ Powerline:h22
    " set guifont=CosmicSansNeueMono:h22
    " set guifont=IBMPlexMono:h22
    set guifont=JetBrains\ Mono:h20
    set transparency=10
endif

set printoptions=paper:letter,portrait:n

"Set leader key
let mapleader = ","
let maplocalleader = ","

filetype on
set nocompatible
set wildignore=*.dll,*.o,*.obj,*.bak,*.pyc,*.swp

syntax enable
" set smartindent

set tabstop=4  " Tabs are 2 spaces
set backspace=indent,eol,start
set shiftwidth=4  " Tabs under smart indent
set softtabstop=4
set expandtab

set dir=/var/tmp

set cursorline
set number
set hlsearch

" Ignore/smart case sensitive searching
set ic
set scs

" Save all files on focus lost
:au FocusLost * :wa
" on focus lost exit insert mode
:au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

:filetype plugin on

if has("autocmd")
  filetype indent on
endif

map <D-/> <Plug>NERDCommenterToggle
nnoremap <c-t> :FZF<cr>

if has("gui_macvim")
  "map <D-t> :CtrlP<CR>
  "let g:ctrlp_map = '<D-t>'
  "let g:ctrlp_tabpage_position = 'al'
  "let g:ctrlp_open_new_file = 't'
endif

let g:crystal_auto_format=1

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
nnoremap ; :Buffers<CR>
nnoremap s :Ags 

vmap <leader>x :'<,'>!xmlformat -<CR>
nmap <leader>x V:'<,'>!xmlformat -<CR>

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a; :Tabularize /:\zs<CR>
  vmap <Leader>a; :Tabularize /:\zs<CR>
  nmap <Leader>a> :Tabularize /=><CR>
  vmap <Leader>a> :Tabularize /=><CR>
  nmap <Leader>a. :Tabularize /=><CR>
  vmap <Leader>a. :Tabularize /=><CR>
endif

let g:elm_jump_to_error = 1
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_browser_command = ""
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

set rnu
au InsertEnter * :set nu
au InsertLeave * :set rnu
au FocusLost * :set nu
au FocusGained * :set rnu

set laststatus=2

