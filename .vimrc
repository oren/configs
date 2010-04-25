"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"no beeps
set vb t_vb=".

set grepprg=ack-grep\ -a

colorscheme vibrantink

set number    "don't show line number

autocmd FileType ruby set omnifunc=rubycomplete#CompleteRuby
let g:fuzzy_ignore = "gems/*" 

"indent settings
set sts=2
set sw=2
set shiftwidth=4
set softtabstop=2
set expandtab
set autoindent

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

let g:miniBufExplUseSingleClick = 1

autocmd BufWritePre *.rb :call TrimWhiteSpace()

"""key mappings''''''''''''

"buffers
map <M-Right> <Esc>:bn<CR>
map <M-Left> <Esc>:bp<CR>
map <M-t> <Esc>:bn<CR>
map <M-h> <Esc>:bp<CR>
map <M-d> <Esc>:bd<CR>

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
map <F5> <Esc>:wa<CR>
map <F6> :call TrimWhiteSpace()<CR>
map! <F6> :call TrimWhiteSpace()<CR>
map <F12> <Esc>:qa<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

