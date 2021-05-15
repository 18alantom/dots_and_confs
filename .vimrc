" === PLUGINS INSTALLATION ===
"
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'                      " status bar for vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " LSP Client
Plug 'yggdroot/indentline'                        " custom indent lines
Plug 'kien/rainbow_parentheses.vim'               " coloured pairs of parens
Plug 'junegunn/fzf.vim'                           " fuzzyfinder plugin for vim
Plug 'ryanoasis/vim-devicons'                     " plugin that shows icons
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}" uses fzf for CocList
Plug 'sheerun/vim-polyglot'                       " better syntax highlight
Plug 'raimondi/delimitmate'                       " add matching stuff "('{etc
Plug 'joshdick/onedark.vim'                       " colorscheme
Plug 'preservim/nerdtree'                         " file browser
Plug 'preservim/nerdcommenter'                    " commenting made easy
Plug 'tpope/vim-repeat'                           " repeat now works for plugins
Plug 'tpope/vim-surround'                         " surround stuff with "('{etc
Plug 'tpope/vim-fugitive'                         " call git commands from vim
Plug 'ciaranm/detectindent'                       " autoindent
call plug#end()

" 
" === === === === === ===


" === PLUGINS SETUP ===
"
filetype plugin indent on    " req, reset after vim-plug
syntax enable                " req, reset after vim-plug
" 
" let g:indentLine_color_gui = '#3C3E43'
" let g:indentLine_color_term = 237
let g:lightline = {'colorscheme':'onedark'}
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDTreeRespectWildIgnore = 1
let g:fzf_preview_window = ['up:40%', 'ctrl-/']
"
" Set theme (non gui dependent on Terminal theme)
if has('gui_running')
    set guifont=FiraCodeNerdFontCompleteM-Retina:h11
    let g:indentLine_char_list = ['│','╎']
else 
  let g:indentLine_char = '│' " Single char if term for indents
  if has('termguicolors')
    set termguicolors " Sets GUI colors for terminal
  endif
endif
" 
" Uses terminal background colors if non GUI mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) 
    " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
colorscheme onedark
" 
" === === === === === ===


" === SET VALUES ===
"
set rtp+=/usr/local/opt/fzf   " Add fzf to runtime Path
set noendofline               " Else add's an annoying new line at the end
set binary                    " Same reason as above
set nocompatible              " set non vi compatible, req Vundle
set laststatus=2              " Config for lightline
set noshowmode                " Prevent '-- INSERT --' from showing
set encoding=UTF-8            " coc.nvim recommended
set clipboard=unnamed         " Use the system clipboard.
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
function Autosave()
  if &modifiable && (expand("%:p") != "")
    :w
  endif
endfunction

function! s:showDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function EchoAbsolutePath()
  echo expand("%:p")
endfunction
" 
" === === === === === ===


" === COMMANDS ===
" 
command Ap call EchoAbsolutePath()
command! -bang -nargs=* RG call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "
  \. <q-args>, 1, fzf#vim#with_preview(), <bang>0)
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

" Plugin specific mappings
nnoremap <C-P> :FZF<Space>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>r :RG<Space>
nnoremap <leader>g :Rg<Space>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>zl :Lines<CR>
nnoremap <leader>zb :BLines<CR>
nnoremap <leader>cl :CocFzfList<CR>
nnoremap <leader>N :NERDTreeToggle<CR>
nnoremap <leader>di :DetectIndent<CR>
nnoremap <leader>cc :CocFzfList commands<CR>
nnoremap <leader>ca :CocFzfList actions<CR>
nnoremap <leader>cd :CocFzfList diagnostics<CR>
nnoremap <leader>co :CocFzfList outline<CR>
nnoremap <leader>cf :call CocAction('format')<CR>
xnoremap <leader>cf <Plug>(coc-format-selected)

" Map tab step through next, previous
nnoremap gtn :tabn<CR>      
nnoremap gtp :tabp<CR>
nnoremap <leader>t :tabnew<CR>

" Map buffer step through next, previous
nnoremap gbn :bn<CR>
nnoremap gbp :bp<CR>

" NERDCommenter keymaps
nmap <leader>/ <Plug>NERDCommenterToggle
vmap <leader>/ <Plug>NERDCommenterToggle

" Coc toggle keymaps
nnoremap <c-c>e :CocEnable<CR>
nnoremap <c-c>d :CocDisable<CR>

" Coc Go to keymaps
nmap gd <Plug>(coc-definition)                    " goto defn of a var
nmap gr <Plug>(coc-references)                    " got the refs of a var
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)

nnoremap K :call <SID>showDocumentation()<CR>     " <shift-k> for doc
"
" === === === === === === 


" === AUTOCOMMANDS  ===
"
" Autocmds
au FocusLost * :call Autosave()            " Autosave on FocusLost
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
" au Syntax * RainbowParenthesesLoadSquare " Clashes with nerdtree icons
au CursorHold * silent call CocActionAsync('highlight') " highlight references
au BufNewFile,BufRead *.txt
  \ set foldmethod=manual
"
" === === === === === ===


" PLUGINS TO CHECK LATER
"
" https://github.com/weirongxu/coc-explorer
" https://github.com/RRethy/vim-hexokinase
