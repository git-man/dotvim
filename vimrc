" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" === Vundle Section (Plugin-Manager) ==========================================
filetype off	" required

let iCanHazVundle=1
if has('win32') || has('win64')
	set runtimepath=$VIM/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/.vim/after
	let $HOME=$VIM
	let vundle_readme=expand('$VIM\.vim\bundle\vundle\README.md')

	if !filereadable(vundle_readme)
		echo "Installing Vundle.."
		echo ""
		exe '!mkdir ' . shellescape(expand("$HOME")) . "\\.vim\\bundle\\"
		echo "created path..."
		exe '!git clone https://github.com/gmarik/vundle ' . shellescape(expand("$HOME"))."\\.vim\\bundle\\vundle"
		let iCanHazVundle=0
	endif

   let $PATH = 'D:\jsctags;' . $PATH

	"let $HOME = substitute($HOME, " ", "\\\\ ", "")
	"set runtimepath=$HOME/.vim,$HOME/vimfiles,$VIMRUNTIME,$HOME/vimfiles/after,$HOME/.vim/after
else
	let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

	if !filereadable(vundle_readme)
		echo "Installing Vundle.."
		echo ""
		silent !mkdir -p ~/.vim/bundle
		echo $HOME/.vim/bundle
		silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
		let iCanHazVundle=0
	endif
endif

set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" --- My Bundles ---
" - original repos on github -> username/repo_name
"Bundle 'Syntastic' "uber awesome syntax and errors highlighter
"Bundle 'altercation/vim-colors-solarized' "T-H-E colorscheme
Bundle 'tpope/vim-fugitive'
Bundle 'taglist-plus'
Bundle 'jshint.vim'
Bundle 'ccase.vim'
Bundle 'project.tar.gz'
Bundle 'asciidoc.vim'
"Bundle 'JavaScript-Indent'
Bundle 'pangloss/vim-javascript'
"Bundle 'Javascript-Indentation'
"Bundle 'Better-Javascript-Indentation'
"Bundle 'Simple-Javascript-Indenter'
"Bundle 'lukaszb/vim-web-indent'
"Bundle 'Tabular'
Bundle 'matchit.zip'
Bundle 'Align'

" AutomaticLaTeXPlugin ---
"Bundle 'AutomaticLaTeXPlugin'
"Bundle 'https://github.com/coot/atp_vim'
Bundle 'git://git.code.sf.net/p/atp-vim/code'
" ---


" - vim-scripts repos from vim.org site -> script_name
"Bundle 'FuzzyFinder'

" - non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" --- My Bundles END ---

if iCanHazVundle == 0
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:BundleInstall
endif

filetype plugin indent on	" required
" === Vundle END ===============================================================

" Omnicompletion
set ofu=syntaxcomplete#Complete

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set writebackup	" create a backup before writing to file, then remove it
set noswapfile		" disables creation of swapfiles
set history=500	" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
" Press space to clear search highlighting and any message already displayed
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
nmap Q gqap
vmap Q gq

" To filter the history of the command line mode with the <C-p> and <C-n>
" shortcuts like with the <Up> and <Down> keys
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  " Language defined custom settings
  autocmd FileType text setlocal textwidth=80 ai fo=tnaw ts=3 sts=3 sw=3 expandtab
		\ flp=^\\s*\\(->\\\|[0-9*-+]\\+\\\|[a-z]\\)[\\]:.)}\\t]\\s* fo+=roq
		\ colorcolumn=+1 comments-=s1:/*,mb:*,ex:*/ comments+=fb:->,fb:-,fb:+
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab tw=80
  autocmd FileType cs setlocal ts=4 sts=4 sw=4 noexpandtab tw=80
		\ efm=\ %#%f(%l\\\,%c):\ error\ CS%n:\ %m
		\ makeprg=msbuild\ /nologo\ /v:q\ /property:Configuration=Debug;GenerateFullPaths=true
		\ tags=tags,./tags,C:\dotnetReference\RefSrc\Source\.Net\4.0\DEVDIV_TFS\Dev10\Releases\RTMRel\tags;
		\ foldmethod=syntax
		\ foldlevelstart=0
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 noexpandtab fo="" tw=0
  autocmd FileType mail,text,asciidoc,html setlocal spell spelllang=en,de
  autocmd FileType asciidoc
		\ setlocal autoindent expandtab softtabstop=2 shiftwidth=2
		\ formatoptions=tcqn
		\ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
		\ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
	autocmd FileType binMode
		\ setlocal binary ft=xxd fo="" wrap tw=0 noexpandtab nomodeline display=uhex noeol

  autocmd bufnewfile,bufread .vimrc,_vimrc,*.vimrc setlocal ft=vim
  autocmd bufnewfile,bufread *.txt,*.prot,README,TODO,CHANGELOG,NOTES,INSTALL
		\ setlocal ft=text
  autocmd bufnewfile,bufread *.log,*.log.old setlocal fo=""
  autocmd bufnewfile,bufread ~/AsciiDoc/*.txt setlocal filetype=asciidoc
  autocmd bufnewfile,bufread *.bin,*.arc setlocal filetype=binMode
  
  " Syntax Highlighting for vb-files
  autocmd BufNewFile,BufRead *.vb setlocal ft=vbnet
  " Treat .jst, .json files as JavaScript
  autocmd BufNewFile,BufRead *.js,*.jst,*.json setlocal ft=javascript
  autocmd BufNewFile,BufRead *.js,*.jst,*.json call CorrectBracketHandling()

  autocmd BufNewFile,BufRead *.cs setlocal ft=cs
  autocmd BufNewFile,BufRead *.cs call CorrectBracketHandling()

	" Regenerate tags file for my personal wiki
	autocmd BufWritePost D:/Dokumentation/Wiki/* :helptags D:/Dokumentation/Wiki

  " For making the window of plugin projects fixed in their size
  autocmd BufWinEnter *.vimprojects setlocal wfw
  autocmd BufWinEnter *.vimprojects setlocal wfh

  " If no filetype set, set a certain ft
  autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
	 \ if line("'\"") > 1 && line("'\"") <= line("$") |
	 \   exe "normal! g`\"" |
	 \ endif
else
  set autoindent		" set autoindenting on, indents like the previous line
endif " has("autocmd")

if executable("par")
	exe 'set formatprg=par\ -qrgpdhw' . &tw
endif

" status bar is always displayed and not only at specific amount of windows
set laststatus=2

" Will make VIM display stats of the file in the status bar
set statusline=%02n:%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" switch to pastemode
set pastetoggle=<F2>

" disable "ding" sounds
set vb t_vb=

"disable beeps
set noerrorbells

" Sets global textwidth
set tw=80

" Sets the global shiftwidth
set shiftwidth=3

" Sets the global tabstop
set tabstop=3

" Number of spaces tabs consists of while editing (pseudo-tabs)
set softtabstop=3

" Don't replace tabs with spaces
set noexpandtab

" Hightlights the cursor's line
set cul

" Highlight the cursor's column
set cursorcolumn

" Numbers each line
set number

" line numbering options
" Width of the gutter column
set numberwidth=5
" color used for the line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" color used for the ColorColumn
"highlight ColorColumn guibg=#121212
highlight ColorColumn guibg=#4F4F4F

" Handle unsaved buffers
set hidden

" Change the terminals title
set title

command! -nargs=* Wrap set wrap linebreak nolist

" For moving around in long soft wrapped lines
vmap <C-j> gj
vmap <C-k> gk
vmap <C-4> g$
vmap <C-^> g^
vmap <C-0> g^
nmap <C-j> gj
nmap <C-k> gk
nmap <C-4> g$
nmap <C-^> g^
nmap <C-0> g^

" sets colorscheme dependent on using either gui or terminal
set t_Co=256 "enable 256 colors
if has('gui_running')
  colorscheme wombat
else
  colorscheme wombat256
endif

" Improve performance in XML-Files with large lines by constraining the
" Syntax Highlighting
set synmaxcol=400

" Easier brackets handling
inoremap {<cr> {<cr>}<c-o>O<tab>
"inoremap {<CR> {<CR>}<Esc>:let leavechar="}"<CR>O
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap ( ()<Esc>:let leavechar=")"<CR>i
"inoremap " ""<Esc>:let leavechar="\""<CR>i
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap [ []<Esc>:let leavechar="]"<CR>i
imap <c-j> <Esc>:exec "normal f" . leavechar<CR>a

function! CorrectBracketHandling()
	inoremap {<cr> {<cr>}<c-o>O
	"inoremap {<CR> {<CR>}<Esc>:let leavechar="}"<CR>O
	inoremap { {}<Esc>:let leavechar="}"<CR>i
	inoremap ( ()<Esc>:let leavechar=")"<CR>i
	"inoremap " ""<Esc>:let leavechar="\""<CR>i
	inoremap [<cr> [<cr>]<c-o>O
	inoremap [ []<Esc>:let leavechar="]"<CR>i
	imap <c-j> <Esc>:exec "normal f" . leavechar<CR>a
endfunction


" Sets clever search options
" if search pattern consists of only lower-case --> ignorecase search
" else if one or more upper-case characters --> case-sensitive search
set ignorecase
set smartcase

" Keep some context around the cursors position
set scrolloff=3

" File name completion
set wildmenu
set wildmode=longest,list
"set wildmode=longest,full

" *** GUI-Settings
"set guifont=Monospace\ 10 " sets font
set guifont=Inconsolata\ Medium\ 14,Monospace\ 10,Inconsolata\ LGC:h14 " sets font tried by order
set lines=55
set columns=100
set mousehide " hide the mouse cursor when typing
set guioptions-=T "remove toolbar

" *** Highlight characters that exceed the 80th column ************************
"if exists('+colorcolumn')
"	set colorcolumn=80
"else
"	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

" Full screen at startup
if has("gui_win32")	" NT Windows
	 autocmd GUIEnter * :simalt ~x
endif


let mapleader = ','

" For simply editing files in same directory of the current file in window by
" expanding the path
cnoremap ~~ <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e ~~ 
map <leader>es :sp ~~
map <leader>ev :vsp ~~

" Strip trailing whitspaces ***************************************************
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" *****************************************************************************

" Comfortably switching HEX mode ***
let $in_hex=0
function HexMe()
	setlocal binary noeol ft=xxd fo="" wrap tw=0 noexpandtab nomodeline display=uhex noeol
	if $in_hex>0
		:%!xxd -r
		let $in_hex=0
	else
		:%!xxd
		let $in_hex=1
	endif
endfunction
" *** HEX mode function END

" JavaScript JSON extraction
nmap <leader>jt 0 % % i<CR><ESC> % a <CR><ESC> k :.!python -mjson.tool<CR> y% u :vnew!<CR> p :set ft=javascript<CR><ESC>

" C# tags generation
nmap <leader>cst :!ctags.exe -R --extra="+fq" --fields=+ianmzS --c\#-kinds=cgimnps --languages=c\#<CR>

" *** Project plugin related settings *****************************************
"map <A-S-p> :Project<CR>
"map <A-S-o> :Project<CR>:redraw<CR>/
"nmap <silent> <F3> <Plug>ToggleProject
let g:proj_window_width = 30
let g:proj_window_increment = 50
let g:proj_flags="imst"
" *****************************************************************************


" *** OmniCppComplete *********************************************************
" :inoremap <expr> <CR> pumvisible() ? "\<c-y>" : "\<c-g>u\<CR>"
" set completeopt as don't show menu and preview
set completeopt=menuone
" Popup menu hightLight Group
"highlight Pmenu ctermbg=13 guibg=LightGray
"highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
"highlight PmenuSbar ctermbg=7 guibg=DarkGray
"highlight PmenuThumb guibg=Black
" use global scope search
let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 1
" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1
" This option can be use if you don't want to parse using namespace declarations in included files and want to add namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]
" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0
" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0
" *****************************************************************************

" *** Tell Vim where to search for tags ***************************************
" To find the tags per project:
"set tags=./.tags;${HOME}
" To load system wide libraries based on filetype:
"au BufRead,BufNewFile *.java setlocal tags+=~/.vim/tags/javatags 
"au BufRead,BufNewFile *.cpp,*.h setlocal tags+=~/.vim/tags/c++libtags
"au BufRead,BufNewFile *.c,*.cpp,*.h setlocal tags+=~/.vim/tags/clibtags
" *****************************************************************************

" *** TagList related settings ************************************************
" let Tlist_Ctags_Cmd='/usr/local/bin/exctags'	 " Use this one in FreeBSD
"let Tlist_Ctags_Cmd='/usr/bin/ctags'				 " Use this one in Linux
"let Tlist_Auto_Open=0
"let Tlist_Auto_Update=1
"let Tlist_Use_Horiz_Window = 0
""let Tlist_Inc_Winwidth=0
""let Tlist_Show_One_File=1
"let Tlist_Exist_OnlyWindow=1
"let Tlist_Use_Right_Window = 1
"let Tlist_Sort_Type="name"
"let Tlist_Display_Prototype=0
"let Tlist_Compact_Format=1 " Compact?
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Display_Tag_Scope=1
"let Tlist_Close_On_Select=0
"let Tlist_Enable_Fold_Column=1
"let TList_WinWidth=25
"
"" Map a F8 to the TlistToggle command for easy tags list access
"nnoremap <silent> <F8> <ESC>:TlistToggle<CR>
" *****************************************************************************

" *****************************************************************************
" For using TagBar instead
" *****************************************************************************
"nmap <F8> :TagbarToggle<CR> 
"
"let g:tagbar_type_javascript = {
"	\ 'ctagsbin' : '/usr/bin/jsctags'
"\ }
" *****************************************************************************


" $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
"
" show invisible characters
nmap <leader>l :set list!<CR>

" Run JSHint to lint the current JavaScript file with the specified rules
nmap <silent> <leader>i :JSHint --config X:\mcis_tdi\Scripts\CI\tools\jshint\config.json %<CR>

if has('win32') || has('win64')
	" Use the same symbols as TextMate for tabstops and EOLs
	set lcs=tab:»\ ,eol:¬,trail:·
else
	set lcs=tab:â–¸\ ,eol:Â¬,trail:·
endif

" if exists(":Tabularize")
"  nmap <Leader>a= :Tabularize /=<CR>
"  vmap <Leader>a= :Tabularize /=<CR>
"  nmap <Leader>a: :Tabularize /:\zs<CR>
"  vmap <Leader>a: :Tabularize /:\zs<CR>
" endif

" Format xml-file by using external program 'xmllint'
nmap <leader>xml :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>



function! ProtoSkeleton()
  let s:line=line(".")
  call setline(s:line,"Protokoll")
  call append(s:line,"=========")
  call append(s:line+1,"")
  call append(s:line+2,"Thema: %%%")
  call append(s:line+3,"Teilnehmer: %%%")
  call append(s:line+4,"Datum: ".strftime("%a, %d %b %Y %H:%M:%S %z"))
  call append(s:line+5,"")
  call append(s:line+6,"Ausgangssituation")
  call append(s:line+7,"-----------------")
  call append(s:line+8,"%%%")
  call append(s:line+9,"")
  call append(s:line+10,"LÃ¶sung")
  call append(s:line+11,"------")
  call append(s:line+12,"%%%")
  call append(s:line+13,"")
  call append(s:line+14,"ToDo")
  call append(s:line+15,"----")
  call append(s:line+16,"%%%")
  call append(s:line+17,"")
  unlet s:line
endfunction

nmap <leader>pro mz:execute ProtoSkeleton()<CR> <Esc>
