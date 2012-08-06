"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"no beeps
set vb t_vb=".  
syntax enable

" set guifont=Menlo:h20
" set background=light
set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility="high"
let g:solarized_contrast="high"
colorscheme solarized


" set sts=2
" set sw=2

"indent settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set hidden                     " hide buffers when not displayed
set cursorline                 " highlight the line of the cursor
set ttyfast                    " faster pasting and smooth redrawing
set ignorecase                 " ignore case if all chars are lower
set smartcase
set gdefault                   " substitutions apply on all the line
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000               " store lots of :cmdline history
set directory=/var/tmp         " swp files
set showcmd                    " show incomplete cmds down the bottom
set showmode                   " show current mode down the bottom
set incsearch                  " find the next match as we type the search
set showmatch
set hlsearch                   " hilight searches by default
set wildmode=list:longest      " make cmdline tab completion similar to bash
set wildmenu                   " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~    " stuff to ignore when tab completing

" find how to change location of tmp files
" set undofile                   " undo works even after reopening a file


" matches closing { with tab
nnoremap <tab> %
vnoremap <tab> %
set scrolloff=3
                               " ; is easier than :
nnoremap ; :
                               " hh is easier than esc
inoremap hh <ESC>
au FocusLost * :wa             " save on lost focus
"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>
"map Q to something useful
noremap Q gq
"make Y consistent with C and D
nnoremap Y y$
"move between splits
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

"leader
let mapleader = ","
let g:mapleader = ","
nnoremap <leader>a :Ack
inoremap <leader>c <C-x><C-o>

" handle long lines
set nowrap
" set textwidth=79
" set formatoptions=qrn1
" set colorcolumn=85 

"old settings. might go back to this
" set nowrap                     " dont wrap lines
" set linebreak                  " wrap lines at convenient points
" set formatoptions-=o "dont continue comments when pushing o/O

"remove some status line clutter made by rails.vim
let g:rails_statusline=0
"set statusline=%f       "full path
set statusline=%t     " tail only filename from path
set statusline+=%h    " help file flag
set statusline+=%m    " modified flag
set statusline+=%r    " read only flag
set statusline+=%=    " left/right separator
set statusline+=%c,   " cursor column
set statusline+=%l/%L " cursor line/total lines
set statusline+=\ %P  " percent through file
set laststatus=2      " always show status line

"folding settings
set nofoldenable                         "dont fold by default
set foldmethod=expr                      " fold by expression
set foldexpr=getline(v:lnum)=~'^\\s*#'     " fold lines that start with #
set fillchars="fold: "                   " get rid of ---
" get rid of underline
hi Folded term=NONE cterm=NONE gui=NONE ctermbg=None 
set foldtext="" " don't show text of first commented line when folded

"display tabs and trailing spaces
" set list
" set listchars=tab:▸\\ ,eol:¬


"load ftplugins and indent files
filetype plugin on
filetype indent on


"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2


"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction

"define :HighlightExcessColumns command to highlight the offending parts of
"lines that are "too long". where "too long" is defined by &textwidth or an
"arg passed to the command
command! -nargs=? HighlightExcessColumns call s:HighlightExcessColumns('<args>')
function! s:HighlightExcessColumns(width)
    let targetWidth = a:width != '' ? a:width : &textwidth
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth+1) . 'v/'
    else
        echomsg "HighlightExcessColumns: set a &textwidth, or pass one in"
    endif
endfunction

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

autocmd BufWritePre *.rb :call TrimWhiteSpace()
let g:miniBufExplUseSingleClick = 1

"""key mappings''''''''''''
" M-right = alt+arrow
" C = ctrl

"buffers
map <C-h> <Esc>:bn<CR>
map <C-t> <Esc>:bp<CR>
map <C-d> <Esc>:bd<CR>

"alt keys
nmap <M-1> <Esc>:b1<CR>
nmap <M-2> <Esc>:b2<CR>
nmap <M-3> <Esc>:b3<CR>
nmap <M-4> <Esc>:b4<CR>
nmap <M-5> <Esc>:b5<CR>
nmap <M-6> <Esc>:b6<CR>
nmap <M-7> <Esc>:b7<CR>
nmap <M-8> <Esc>:b8<CR>
nmap <M-9> <Esc>:b9<CR>

"F keys
set pastetoggle=<F3> " hit this before pasting to fix indentation
map <F1> :e.<CR>
nnoremap <F2> :set nonumber!<CR>
map <F4> :TlistToggle<CR>
call togglebg#map("<F5>") " used by solarized color scheme
" F9 to toggle folds
inoremap <F9> <C-O>zi
nnoremap <F9> zi
onoremap <F9> <C-C>zi
vnoremap <F9> zi

"fuzzy finder with ctrl+p
let g:ctrlp_map = '<c-p>'

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode


"add \v to regex search - not working
" nnoremap / /\\v 
" vnoremap / /\\v


au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.mustache set filetype=html
au BufNewFile,BufRead *.styl set filetype=css

let g:syntastic_mode_map = { 'mode': 'passive' }
