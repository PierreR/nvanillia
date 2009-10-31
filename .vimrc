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
set smartindent "fair enough default for all devel file but what about txt ...

inoremap <Tab> <C-N>
set complete=.,w,b,t,i "current buffer, visible buffer, loaded buffer, tags and include
set completeopt=menuone,longest
"Simulate "down" when the pmenu is visible so that one is always highlight
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-n>\<Down>"
"Map the enter key to select when the pmenu is visible 
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" MAPPING: use noremap instead of map to avoid recursive problem unless you map a mapping ...
noremap <Home> ^
inoremap <Home> <Esc>^i
noremap µ `

syntax on
au BufNewFile,BufRead *.j setf objj
au BufRead,BufNewFile *.txt		setfiletype text "no sure to understand why this filetype does not work out of the box

"autocmdd Filetype text set nosmartindent
filetype plugin indent on

" Set an orange cursor in Insert mode, and red cursor otherwise.
" " Works at least for xterm and rxvt terminals
" " Does not work at least for gnome terminal, konsole, xfce4-terminal
if &term =~ "konsole"
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"if &term =~ "xterm\\|rxvt|konsole"
