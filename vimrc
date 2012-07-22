"clear existing commands
autocmd!

set nocompatible
let mapleader = ","

" Remap Esc so I don't have remove my hand from the home row
imap jj <Esc>

" Indenting ********************************************************************

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab

" Misc settings ****************************************************************

set ffs=unix,dos
set vb t_vb=
set hidden

" NERDTree stuff  *********************************************************************
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['^\.git$', '^RCS$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
noremap <Leader>d :NERDTreeToggle<CR>

" Timeouts *********************************************************************

set timeout
set ttimeout
set timeoutlen=500
set ttimeoutlen=500

" Colors ***********************************************************************

syntax enable
set term=screen-256color
set t_Co=256
syntax on " syntax highlighting

if &term =~ ".*256color"
    colorscheme xoria256
else
    colorscheme ir_black
endif

" Want to make sure the bad space highlighting is not overwritten.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight any extra white space regardless of the color scheme I am using.
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
match ExtraWhitespace /\s\+$/

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" highlight matching brackets add ' and " ??
set matchpairs+=<:>


" Status/Tab Line **************************************************************


set showcmd
set ruler " Show ruler
set laststatus=2
set showtabline=0

hi StatusLine ctermbg=22 ctermfg=White

hi User1 ctermbg=9 ctermfg=0 guibg=9 guifg=0
hi User2 ctermbg=22 ctermfg=40 guibg=22 guifg=51

set statusline=                      " clear out the status line.
set statusline+=[%R%M]               "File flags
set statusline+=\%{Get_nice_path()}  "Nicely formating full path of file
set statusline+=%=%h%w\              "Right justify

" IS SYNTACTIC!! TODO: add syntactic back.
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" I *REALLY* don't line trailing whitespace.
set statusline+=%1*
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%*\ 

" I like mixed whitespace even less then trailing white space.
set statusline+=%1*
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*\ 

set statusline+=[FORMAT=%{&ff}]\     "file format
set statusline+=[TYPE=%Y]\           "file type
set statusline+=[ASCII=\%04.3b]\     "decimal value of the char the cursor is on.
set statusline+=[HEX=\%02.2B]\       "HEX value of the char the cursor is on.

" Cursor position
set statusline+=[POS=                "Start
set statusline+=%2*                  "Line
set statusline+=%04l                 "Line
set statusline+=%*                   "Line
set statusline+=,
set statusline+=%04v                 "Char
set statusline+=]\                   "End

set statusline+=[%02p%%]\            "Percent through the file
set statusline+=[LEN=%L]             "Length of the file

autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
        return b:statusline_tab_warning
endfunction

function! Get_nice_path()
    let l:fpath = expand("%:p")

    if l:fpath =~ "\.global\/...."
	    return substitute( l:fpath, "\/\.global\/....", '', '')
    endif

    return l:fpath
endfun

" Fold Lines *******************************************************************

set foldenable
set foldmethod=indent
set foldminlines=3

let perl_fold=1
let perl_nofold_packages=1

" Directories ******************************************************************

" TODO: check to make sure they exist and create them if they do not.
set directory=~/.vim/swap
set backupdir=~/.vim/backup
set backup

" Spell check  *****************************************************************
"
set spellfile=~/.vim/spellfile.add
set sps=best,15
let perl_include_pod=1
set spell spelllang=en_us

" Searching  *******************************************************************

set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

" Formating ********************************************************************

"set formatoptions=tcanw
set comments=sl:##,mb:##,elx:#
set textwidth=120

" Line Wrapping ****************************************************************

set nowrap
set linebreak  " Wrap at word

" Invisible characters *********************************************************

set listchars=trail:.,tab:>-,eol:$
set nolist
noremap <Leader>i :set list!<CR> " Toggle invisible chars

" File type specific ***********************************************************

filetype on
filetype plugin indent on

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

autocmd BufNewFile,BufRead *.jil set filetype=jil


" Key mapping ******************************************************************

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" this toggles between past and no past mode
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

" tabs to spaces
nnoremap <silent> <F5> :%s/\t/    /g<CR>

" Automaticly clean trailing White Space
" nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

"Hard to type
imap uu _
imap hh =>
imap aa @

" make wrapped lines easer to navigate.
noremap j gj
noremap k gk

" Startup **********************************************************************

" only want NERDTree if I don't pass in a file to edit.
if empty(bufname("%"))
    autocmd VimEnter * exe 'NERDTree' | wincmd l
endif
