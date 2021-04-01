" === PLUGINS INSTALLATION ===
"
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'                      " status bar for vim
Plug 'preservim/nerdtree'                         " file browser
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " LSP Client
Plug 'yggdroot/indentline'                        " custom indent lines
Plug 'kien/rainbow_parentheses.vim'               " coloured pairs of parens
Plug 'sainnhe/edge'                               " colorscheme
Plug 'junegunn/seoul256.vim'                      " colorscheme
Plug 'junegunn/fzf.vim'                           " fuzzyfinder plugin for vim
Plug 'ryanoasis/vim-devicons'                     " plugin that shows icons
Plug 'antoinemadec/coc-fzf'                       " uses fzf for CocList
Plug 'sheerun/vim-polyglot'                       " better syntax highlight
Plug 'preservim/nerdcommenter'                    " commenting made easy
call plug#end()
" 
" === === === === === ===


" === PLUGINS SETUP ===
"
filetype plugin indent on    " req, reset after vim-plug
syntax enable                " req, reset after vim-plug
" 
"
let g:lightline = {'colorscheme':'seoul256'}
let g:indentLine_color_gui = '#3C3E43'
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:indentLine_color_term = 237
let g:seoul256_background = 234
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDTreeRespectWildIgnore = 1
"
" Set theme (non gui dependent on Terminal theme)
if has('gui_running')
    let g:indentLine_char_list = ['│','╎']
else 
  let g:indentLine_char = '│' " Single char if term for indents
  if has('termguicolors')
    set termguicolors " Sets GUI colors for terminal
  endif
endif

colorscheme seoul256
highlight LineNr guibg=#262525
" 
" === === === === === ===


" === SET VALUES ===
"
set laststatus=2              " Config for lightline
set noshowmode                " Prevent '-- INSERT --' from showing
set encoding=UTF-8            " coc.nvim recommended
set nocompatible              " set non vi compatible, req Vundle
set clipboard=unnamed         " Use the system clipboard.
set rtp+=/usr/local/opt/fzf   " Add fzf to runtime Path
set number                    " set line numbers
set autoindent                " Inherit indentation
set expandtab                 " Convert tabs to spaces
set shiftwidth=2              " Shift (>>,<<) by 2 spaces
set tabstop=2                 " Indent using 2 spaces
set smartindent               " Syntax dependent indenting
set textwidth=80              " Set text wrap at 80 chars
set hlsearch                  " Search (/) highlighting
set ignorecase                " Ignorecase while search (smartcase not working)
set foldmethod=indent         " Code folding by indent
set nofoldenable              " Open notebooks unfolded
set signcolumn=number         " Sign column and number column are the same
set updatetime=300            " 300ms before swap written to disk
set shortmess+=c              " Don't pass messages to ins-completion-menu (?)
" 
" Set wild ignore ()
set wildignore+=*.pyc
set wildignore+=*/node_modules,*/__pycache__
"
" === === === === === ===


" === FUNCTIONS ===
"
" Function definitions (move to a different file maybe?)
function Autosave()
  " Better autosave on type : https://stackoverflow.com/a/27387138/9681690
  if &modifiable
    :w
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" 
" === === === === === ===


" === MAPPINGS ===
" 
let mapleader = "\<Space>"

" horizontal and vertical split remaps
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" pane movement remaps
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Create a new tab
nnoremap <leader>t :tabnew<CR>

" Plugin specific mappings
nnoremap <C-P> :FZF<Space>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>zl :Lines<CR>
nnoremap <leader>zb :BLines<CR>
nnoremap <leader>N :NERDTree<CR>
nnoremap <leader>cl :CocFzfList<CR>
nnoremap <leader>cc :CocFzfList commands<CR>
nnoremap <leader>ca :CocFzfList actions<CR>
nnoremap <leader>cd :CocFzfList diagnostics<CR>

" Map tab step through next, previous 
nnoremap gtn :tabn<CR>
nnoremap gtp :tabp<CR>

" Map buffer step through next, previous
" nnoremap gbn :bn<CR>
" noremap gbp :bp<CR>

" NERDCommenter keymaps
nmap <leader>/ <Plug>NERDCommenterToggle
vmap <leader>/ <Plug>NERDCommenterToggle

" Coc Go to keymaps
"
" Coc toggle keymaps
nnoremap <c-c>e :CocEnable<CR>
nnoremap <c-c>d :CocDisable<CR>
"
nmap gd <Plug>(coc-definition)                     " goto defn of a var
nmap gr <Plug>(coc-references)                     " got the refs of a var
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
"
nnoremap K :call <SID>show_documentation()<CR>     " <shift-k> for doc
"
" === === === === === ===
 


" === AUTOCOMMANDS  ===
"
" Autocmds
au FocusLost * :call Autosave()            " Autosave on FocusLost
au VimEnter * RainbowParenthesesToggle     " Enable rainbow parens
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
au CursorHold * silent call CocActionAsync('highlight') " highlight references
" au Syntax * ainbowParenthesesLoadSquare " Clashes with nerdtree icons
"
" === === === === === ===


" PLUGINS TO CHECK LATER
"
" https://github.com/weirongxu/coc-explorer
" https://github.com/RRethy/vim-hexokinase
" https://github.com/tpope/vim-surround
" https://github.com/tpope/vim-fugitive