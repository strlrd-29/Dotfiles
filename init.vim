"enable all features on vim and neovim
:set nocompatible

"Detect file type
:filetype plugin on

"show line number
:set number

"show relative line number
:set relativenumber

"set the default tab spacing
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4

"syntax highlighting
:syntax on

"scroll before we ht the top or bottom
:set scrolloff=8

"commands autocomplete
:set wildmenu
:set wildmode=longest,list,full

"set history of commands 500
:set history=500

"show a line where 80 character is when editing
:set colorcolumn=120

"reload file if it changes outside of vim
:set autoread

"no backup
:set nobackup
:set noswapfile
:set nowritebackup

"hide abandoned buffer, meaning if we have unsaved changes in a buffer we
"can open another one without being forced to save.
:set hidden

"show the signcolumn for things like git
":set signcolumn=yes

"remap jj as shortcut to get out of insert mode
imap jj <Esc>

"disable the evil arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"map Ctrl+HJKL to move between splits
noremap <C-H> <C-W><C-h>
nnoremap <C-J> <C-W><C-j>
nnoremap <C-K> <C-W><C-k>
nnoremap <C-L> <C-W><C-l>

"move between buffers
nmap <Tab> :bn<CR>

"create vertical splits with <leader>v
nmap <leader>v :vnew<CR>

"create horizontal split with <leader>h
nmap <leader>h :sp<CR>

"save file with <CTRL>s
nmap <C-s> :w<CR>

"exit
nmap <leader>q :q!<CR>

"jump to config file for nvim
nmap <leader><leader>v :e ~/.config/nvim/init.vim<CR>

call plug#begin()

"Github Copilot
Plug 'github/copilot.vim'

"Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"JSX syntax highlighting
Plug 'maxmellon/vim-jsx-pretty'

"syntax highlighting in case of using styled components
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"auto closing tag (html, jsx, tsx ...)
Plug 'alvan/vim-closetag'

"auto closing pairts ("", '', (), {} ...)
Plug 'jiangmiao/auto-pairs'

"code formatter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"status bar
Plug 'vim-airline/vim-airline' "status bar
Plug 'vim-airline/vim-airline-themes'

"file explorer
Plug 'https://github.com/preservim/nerdtree' " NerdTree

"shortcut for commenting
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

"color highlighting
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview

"awesome themes
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons

"autocomplete
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion

"C C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'

set encoding=UTF-8

call plug#end()

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
" Toggle terminal on/off (neovim)
nnoremap <C-t> :call TermToggle(12)<CR>
inoremap <C-t> <Esc>:call TermToggle(12)<CR>
tnoremap <C-t> <C-\><C-n>:call TermToggle(12)<CR>

"use K to show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"Nerd tree toggle
nnoremap <C-b> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable=""
let g:NERDTreeDirArrowCollapsible=""

"Airline theme
let g:airline_theme='dark'


"prettier setup
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md Prettier
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"default colorscheme
:colorscheme purify

"auto close tag filenames
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.ts'


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
