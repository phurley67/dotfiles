execute pathogen#infect()

syntax on
filetype plugin indent on

if has('gui_running')
  set background=dark
   colorscheme solarized 
   colorscheme slate
endif

lua << EOF
require'lspconfig'.solargraph.setup{}
EOF

