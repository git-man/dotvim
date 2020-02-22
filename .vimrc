" ----------------------------------------------------------------------------
" General settings
" ----------------------------------------------------------------------------
" Enter the current millenium
set nocompatible

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin indent on

" Disable "ding" sounds
set vb t_vb=

" Disable beeps
set noerrorbells

" Change leader key, '\' by default
"let mapleader = ','
" ----------------------------------------------------------------------------

" Add package manager
" Since version 8 package management has been enabled officially
" ----------------------------------------------------------------------------
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add some aliases for easier package handling
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
" ----------------------------------------------------------------------------
" Install/use the following bunch of packages
" ----------------------------------------------------------------------------
" Asynchronous related making use of Vims job feature 8+
call minpac#add('skywind3000/asyncrun.vim')
" Useful mappings
call minpac#add('tpope/vim-unimpaired')
" Syntax highlighting
call minpac#add('morhetz/gruvbox')
call minpac#add('PProvost/vim-ps1')
call minpac#add('pboettch/vim-cmake-syntax')
" Formatting
call minpac#add('godlygeek/tabular')
" Version control
call minpac#add('tpope/vim-fugitive')
" Common editor config to follow coding guidelines
call minpac#add('editorconfig/editorconfig-vim')
" CMake related
call minpac#add('vhdirk/vim-cmake')
" File finding and searching, see:
" https://github.com/ctrlpvim/ctrlp.vim
" https://www.mattlayman.com/blog/2019/supercharging-vim-navigate-files-instantly/
call minpac#add('ctrlpvim/ctrlp.vim')
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" View related settings
" ----------------------------------------------------------------------------
" Set default colorscheme by order, last takes precedence, silent ign errors
silent! colorscheme koehler
silent! colorscheme gruvbox
" Set dark background
set background=dark
" True colors for terminal available, if vim >=8.0 or Neovim >= 0.1.5
"if (has('vcon'))
if (has('termguicolors'))
  set termguicolors
endif
" Color used for the line numbers
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE
"  \ guifg=DarkGrey guibg=NONE
" Color used for the ColorColumn
"highlight ColorColumn guibg=#121212
highlight ColorColumn guibg=#9C0C20

" Improve performance in XML-Files with large lines by constraining the
" Syntax Highlighting
set synmaxcol=400

" Sets font tried by order
set guifont=Inconsolata\ Medium\ 19,Monospace\ 15,Consolas:h13 

" Full screen at startup
if has("gui_win32")	" NT Windows
  autocmd GUIEnter * :simalt ~x
endif

" Status bar is always displayed and not only at specific amount of windows
set laststatus=2

"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
set statusline=%!MyStatusLine()

" Change the terminals title
set title

" Hide the mouse cursor when typing
set mousehide

" Remove toolbar
set guioptions-=T

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Keep some context around the cursors position
set scrolloff=3

" Hightlights the cursor's line
set cul
" Highlight the cursor's column
set cursorcolumn
" Show the cursor position all the time
"set ruler			

" Highlight search
set hlsearch

" Ignore whitespace in vimdiff
set diffopt+=iwhite

" Numbers each line
set number
" Line numbering options
" Width of the gutter column
set numberwidth=5

" Define how to display invisible characters like EOLs
if has('win32') || has('win64')
	set lcs=tab:>-,space:.,eol:$,nbsp:~,trail:.
	let &showbreak = '^'
else
	set lcs=tab:>-,space:.,eol:$,nbsp:~,trail:.
	let &showbreak = '^'
endif
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Search settings
" ----------------------------------------------------------------------------
" Sets clever search options
" if search pattern consists of only lower-case --> ignorecase search
" else if one or more upper-case characters --> case-sensitive search
set ignorecase
set smartcase
" Automatically search for the next item
set incsearch

" Search for selected text, forwards or backwards.
" See: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Backup and history settings
" ----------------------------------------------------------------------------
" Create a backup before writing to file, then remove it
set writebackup	
" Disables creation of swapfiles
set noswapfile		
" Keep 500 lines of command line history
set history=500	
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Buffer related settings
" ----------------------------------------------------------------------------
" Handle unsaved buffers
set hidden
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Insert mode settings
" ----------------------------------------------------------------------------
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Set autoindenting on, indents like the previous line
set autoindent
set smartindent
" Using <C-N> or <C-P> don't search all files and include files recursively as
" this takes too much time
set complete-=i
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Finding files

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" With those settings in place it's possible to:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" Things to consider:
" - :b lets you autocomplete any open buffer
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------
" Don't use Ex mode, use Q for formatting
nmap Q gqap
vmap Q gq

" Press space to clear search highlighting and any message already displayed
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" Show invisible characters
nmap <leader>l :set list!<CR>
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Autocommands
" ----------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  autocmd FileType vim setl ts=2 sts=2 sw=2 expandtab tw=78
  " Workaround those 'orphaned' netrw buffers
  " See: https://github.com/tpope/vim-vinegar/issues/13
  autocmd FileType netrw setl bufhidden=wipe
  autocmd FileType cpp setl ts=4 sts=4 sw=4 noexpandtab tw=0 cindent
    \ cino=j1,(0
  autocmd FileType yaml setl ts=2 sts=2 sw=2 expandtab tw=0 autoindent
    \ smartindent
  autocmd FileType markdown setl ts=2 sts=2 sw=2 expandtab tw=80 autoindent
    \ smartindent
  autocmd BufNewFile,BufRead *.rts,*.rrr setlocal ft=cpp
else
  " set autoindenting on, indents like the previous line
  set autoindent
  set smartindent
endif " has("autocmd")
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" netrw aka "Explorer"
" ----------------------------------------------------------------------------
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Grep settings
" ----------------------------------------------------------------------------
" Setup improved Grepper, will be overwritten by fastest (ordering), see:
" https://gist.github.com/igemnace/bf617fa7f84b379feedb39dcf27c0719
" https://www.reddit.com/r/vim/comments/7bj837/favorite_console_tools_to_use_with_vim/dpiixjc/
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
" Provide an async :Grep alternative to :grep
command! -bang -nargs=+ Grep AsyncRun -program=grep @ <args> %:p:h
" Add useful mappings
nnoremap <Leader>* :Grep <cword><CR>
" Search selection in visual mode
" See:
" https://stackoverflow.com/questions/40867576/how-to-use-vimgrep-to-grep-work-thats-high-lighted-by-vim
vnoremap // y:execute 'Grep "' . escape(@@, '/\') . '"'<CR>
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" TAG jumping
" ----------------------------------------------------------------------------
" Create the tags file (ctags needed to be installed on system as precondition)
"command! MakeTags !ctags -R .
if executable('ctags')
  command! MakeTags !start /min ctags -R .
endif

" Cscope ---
" This is not easy to handle on Windows, because it's not that widely
" supported as on Unix based systems
" It has to be installed and added to 'path'
" 
" Another promising option is to use GNU GLOBAL
" https://www.gnu.org/software/global/global.html
"
" Via gtags it can be used via the cscope interface:
" https://www.gnu.org/software/global/globaldoc_toc.html#Gtags_002dcscope
" https://stackoverflow.com/questions/28475573/can-gtags-navigate-back
if has('cscope') && executable('gtags-cscope')
  :set csprg=gtags-cscope
  " If GTAGS file exists in the cwd, add it
  if (filereadable(expand('GTAGS')))
    :cs add GTAGS
  endif
  " To use 'vim -t ', ':tag' and '<C-]>'
  set cscopetag
  set cscopeverbose
  "if has('quickfix')
  "  set cscopequickfix=s-,c-,d-,i-,t-,e-
  "endif
  map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
  command! MakeCstags !start /min gtags .
  "command! MakeCstags !start /min gtags /langmap 'c:.c.h,yacc:.y,asm:.s.S,java:.java,cpp:.c++.cc.hh.cpp.cxx.hxx.hpp.C.H,php:.php.php3.phtml' .
endif

" Cscope + Ctags:
" https://www.embeddedarm.com/blog/tag-jumping-in-a-codebase-using-ctags-and-cscope-in-vim/
" Windows builds:
" https://code.google.com/archive/p/cscope-win32/
" https://github.com/srtlg/cscope-win32
" ---
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Plugin related settings
" ----------------------------------------------------------------------------
" CtrlP
" -----
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif
" Mapping to find buffer by CtrlP
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ignore version control related meta data
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" -----
" EditorConfig
" ------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" ------------
" vim-fugitive
" ------------
" Get cooperate with vim-fugitive
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Custom functions
" ----------------------------------------------------------------------------
" Status line ---
function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "(%{&ff}%(\/%Y%)) "
    " Name of the current branch (needs fugitive.vim)
    let statusline .= "%{fugitive#statusline()}"
    " Left/right separator
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    let statusline .= "0x%02.2B "
    " File progress
    let statusline .= "| %P/%L"
    return statusline
endfunction
" ---

" ----------------------------------------------------------------------------
