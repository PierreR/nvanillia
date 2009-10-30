set nocompatible
colorscheme lucius
set t_Co=256
set mouse=a
set nobackup
set showcmd
set hidden "allow buffer to have hidden changed
set history=100
set textwidth=120
set shell=zsh

set incsearch
set ignorecase
set smartcase "if you use capital search will not ignore case !
nnoremap <silent> * :set invhls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line

set noexpandtab "don't transform tab into spaces by default
set tabstop=4 "nb of space for a tab, fair default (could be set to 2 for html and javascript file)
set shiftwidth=4 " used to (auto) indent with >>, <<; 4 should be the default everywhere !

imap <Tab> <C-N>
set complete=.,w,b,u,t,i,kspell
set completeopt=menuone,longest
"Simulate "down" when the pmenu is visible so that one is always highlight
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-n>\<Down>"
"Map the enter key to select when the pmenu is visible
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

syntax on
au BufNewFile,BufRead *.j setf objj
filetype plugin indent on


