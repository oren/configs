"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"no beeps
set vb t_vb=".

syntax enable
set background=dark
colorscheme solarized

"set number    "show line number

let g:fuzzy_ignore = "gems/*" 

"indent settings
set sts=2
set sw=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"set whichwrap+=<,>,h,l,[,]

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1000   "store lots of :cmdline history

set directory=/var/tmp   "swp files

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

"remove some status line clutter made by rails.vim
let g:rails_statusline=0
"set statusline=%f       "full path
set statusline=%t       "tail only filename from path
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        "always show status line

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

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

"how to map this?
"noremap <silent> ,c<space> :wincmd c<space><cr>

" Move the cursor to the window left of the current one
noremap <silent> ,h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> ,j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> ,k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> ,l :wincmd l<cr>

" Close the window below this one
noremap <silent> ,cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> ,ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> ,ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> ,cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> ,cc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> ,ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> ,mk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> ,mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> ,mj <C-W>J

"buffers
map <C-t> <Esc>:bn<CR>
map <C-h> <Esc>:bp<CR>
map <C-d> <Esc>:bd<CR>

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
map <F1> :NERDTreeToggle<CR>
map <F2> :FuzzyFinderBuffer<CR>
map <F3> :TMiniBufExplorer<CR>
map <F4> :TlistToggle<CR>
call togglebg#map("<F5>")

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

au BufNewFile,BufRead *.ejs set filetype=javascript
au BufNewFile,BufRead *.mustache set filetype=html
":set tags+=$PROJECTROOT/tags
