" ----------------------------------------------------------------------------
" General settings
" ----------------------------------------------------------------------------
" Enter the current millenium
set nocompatible

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin indent on

" Enable 'modeline' explicitly to utilize file-based overrides
" e. g. '# vim: sw=2 ts=2 et'
set modeline

" Disable "ding" sounds
set vb t_vb=

" Disable beeps
set noerrorbells

" Change leader key, '\' by default
"let mapleader = ','

" Adapt runtimepath
" Add custom overrides, e. g. for custom compilers (makeprg)
set runtimepath+=~/.vim/after

" ----------------------------------------------------------------------------

" Add package manager
" Since version 8 package management has been enabled officially
" ----------------------------------------------------------------------------
"  Add the following path to recognize minpac on win via git bash
exe 'set packpath^=' . expand('~/.vim')
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
call minpac#add('Raku/vim-raku')
" Syntax tree related incl. LSP (Language Server Protocol)
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
call minpac#add('mattn/vim-lsp-settings')
" Formatting
call minpac#add('godlygeek/tabular')
" Makeprg + Errorformat
call minpac#add('tpope/vim-dispatch')
" Version control
call minpac#add('tpope/vim-fugitive')
" CMake related
"call minpac#add('vhdirk/vim-cmake')
" File finding and searching, see:
" https://www.mattlayman.com/blog/2019/supercharging-vim-navigate-files-instantly/
"call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
" Navigation
call minpac#add('chrisbra/matchit')
" Respecting project conventions via .editorconfig file, see:
" https://editorconfig.org/
call minpac#add('editorconfig/editorconfig-vim')
" Design, e. g. themes, schemes, icons, etc.
" Always load the vim-devicons as the very last one
" -> Maybe UTF-8 encoding needs to set explicitly via 'set encoding=UTF-8'
call minpac#add('ryanoasis/vim-devicons')
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
highlight ColorColumn guibg=#533028

" Improve performance in XML-Files with large lines by constraining the
" Syntax Highlighting
set synmaxcol=400

" Sets font tried by order
set guifont=Inconsolata\ Medium\ 19,Monospace\ 15,Hack\ Nerd\ Font\ Mono:h12,Consolas:h13 

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
" When set case is ignored when completing file names and directories.
" Has no effect when 'fileignorecase' is set.
" Has no effect on e. g. Windows.
"set wildignorecase
set fileignorecase

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
" Keep 1000 lines of command line history
set history=1000
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
  autocmd FileType json setl ts=2 sts=2 sw=2 expandtab tw=0 autoindent
    \ smartindent
  autocmd FileType yaml setl ts=2 sts=2 sw=2 expandtab tw=0 autoindent
    \ smartindent
  autocmd FileType markdown setl ts=2 sts=2 sw=2 expandtab tw=80 autoindent
    \ smartindent
  autocmd FileType raku setl ts=4 sts=4 sw=4 expandtab tw=0 autoindent
    \ smartindent
  autocmd FileType perl setl ts=4 sts=4 sw=4 expandtab tw=0 autoindent
    \ smartindent
  autocmd FileType ps1 setl ts=4 sts=4 sw=4 expandtab tw=0
    \ cindent cinoptions& cinoptions+=+0 cinkeys-=0#
  " See here: https://winterdom.com/2008/03/18/editingpowershellscriptswithvim
  autocmd FileType cmake setl ts=2 sts=2 sw=2 expandtab tw=0 cindent
  autocmd FileType CMakeLists.txt setl ts=2 sts=2 sw=2 expandtab tw=0 cindent
  autocmd FileType cpp setl ts=4 sts=4 sw=4 noexpandtab tw=0 cindent
    \ cino=j1,(0
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
command! -bang -nargs=+ -complete=file_in_path Grep AsyncRun -program=grep @ <args> %:p:h
" Without automatic path -> user has to manually provide the path
command! -bang -nargs=+ -complete=file_in_path Grepp AsyncRun -program=grep @ <args>
" With path set to CWD for grepping files type of log
" NOTE: The path separator '/' is used here, because it works on win as well
command! -bang -nargs=+ GrepCwdLog execute 'Grepp -i --no-ignore --type log -e fehlgeschlagen:' escape(getcwd(), ' ') . '/<args>'
" Add useful mappings
nnoremap <Leader>* :Grep <cword><CR>
" Search selection in visual mode
" See:
" https://stackoverflow.com/questions/40867576/how-to-use-vimgrep-to-grep-work-thats-high-lighted-by-vim
vnoremap // y:execute 'Grep "' . escape(@@, '/\') . '"'<CR>

" execute 'Grepp -i --no-ignore --multiline --multiline-dotall --type-add rts:*.rts -e T_sObcuStatus::STS_UNDEFINED\s*,\s*[/]*\s*\w+\s*.\s*T_sObcuStatus::SA_NOT_ASSURE,' escape(getcwd(), ' ') . '\modules\tgmt_wcu_sep\TESTS\rttester'
"
" Grep -i --type-add rts:*.rts -trts -e iCmd\s*=\s*0x00
" Grepp -g *.deco -i -e src:34400:\sdst:8201 .
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" TAG jumping
" ----------------------------------------------------------------------------
" Create the tags file (ctags needed to be installed on system as precondition)
"command! MakeTags !ctags -R .
if executable('ctags')
  command! MakeTags !start /min ctags -R --exclude=.git --exclude=./build* --c-kinds=+p .
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
" Debug settings
" ----------------------------------------------------------------------------
" Termdebug
" ---------
" Source the termdebug plugin
"if !exists("g:termdebug_loaded")
packadd! termdebug
"endif
" Use vertical split view by default
let g:termdebug_wide=1
" Add mapping to load termdebug
nmap <silent> <leader>td :Termdebug<cr>
" Add mappings for :Step and :Over
nmap <silent> <leader>s :Step<cr>
nmap <silent> <leader>o :Over<cr>
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Plugin related settings
" ----------------------------------------------------------------------------
"" CtrlP
"" -----
"if executable('rg')
"  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
"endif
"" Mapping to find buffer by CtrlP
"nnoremap <Leader>b :CtrlPBuffer<CR>
"" Ignore version control related meta data
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" ---
" fzf
" ---
if executable('fzf') && exists(':FZF')
  " - down / up / left / right
  let g:fzf_layout = { 'down': '40%' }

  nmap <C-P> :GFiles<CR>
  nmap <Leader>f :GFiles<CR>
  nmap <Leader>F :Files<CR>

  nmap <Leader>b :Buffers<CR>
  nmap <Leader>h :History<CR>

  nmap <Leader>t :BTags<CR>
  nmap <Leader>T :Tags<CR>

  "nmap <Leader>l :BLines<CR>
  "nmap <Leader>L :Lines<CR>
  "nmap <Leader>' :Marks<CR>

  if executable('rg')
    nmap <Leader>/ :Rg<Space>
  endif

  nmap <Leader>H :Helptags!<CR>

  nmap <Leader>C :Commands<CR>

  nmap <Leader>: :History:<CR>

  nmap <Leader>M :Maps<CR>

  nmap <Leader>s :Filetypes<CR>

  "" Taken from official help of FZF
  "function! RipgrepFzf(query, fullscreen)
  "  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  "  let initial_command = printf(command_fmt, shellescape(a:query))
  "  let reload_command = printf(command_fmt, '{q}')
  "  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  "  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  "endfunction
  "command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

endif


function! CMakeConfigurePreset(preset_name, build_path = "build/my_cmake")
  let l:cmd = 'cmake --preset='

  let l:build_path = getcwd() . '/' . a:build_path
  if isdirectory(l:build_path)
    call delete(expand(l:build_path), "rf")
    call delete(expand(getcwd() . '/' . "compile_commands.json"))
  endif
  call mkdir(l:build_path, "p", 0700)

  execute 'Dispatch ' . l:cmd . a:preset_name . ' -B' . l:build_path

  " handle compile_commands.json file to obtain an up-to-date  symlink in the CWD
  if has('win32') || has('win64')
    call system('del compile_commands.json')
    call system('cmd /c mklink compile_commands.json ' . l:build_path . "/compile_commands.json")
  else
    call system('rm compile_commands.json')
    call system('ln -s ' . l:build_path . '/compile_commands.json compile_commands.json')
  endif
endfunction

command! -nargs=+ -complete=shellcmd -complete=file_in_path CMakeConfigurePreset call CMakeConfigurePreset(<f-args>)
nnoremap <leader>cc :CMakeConfigurePreset<space>

function! CMakeBuildDir(clean_before = 0, build_path = "build/my_cmake")
  let l:cmd       = 'cmake --build ' . getcwd() . '/' . a:build_path
  if a:clean_before
    execute 'Dispatch ' . l:cmd . ' --target clean'
  endif
  execute 'Dispatch ' . l:cmd
endfunction

command! -nargs=* -complete=file_in_path CMakeBuildDir call CMakeBuildDir(<f-args>)
command! -nargs=* -complete=file_in_path CMakeBuildCleanDir call CMakeBuildDir(1, <f-args>)
nnoremap <leader>cb :CMakeBuildDir<space>
nnoremap <leader>ccb :CMakeBuildCleanDir<space>

" -------------------------------------
" Undo persist between editing sessions
" -------------------------------------
set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif
augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* /temp/* setlocal noundofile
augroup END

" ------------
" EditorConfig
" ------------
if exists(":EditorConfigEnable")
  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
endif

" ------------
" vim-fugitive
" ------------
" Get AsyncRun cooperate with vim-fugitive

" After fugitive commit: 17db9ca, we are required to provide your own
" asynchronous Gpush and Gfetch
" -> AsyncRun
command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .
          \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .
          \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>
command! -bang -bar -nargs=* Gpull execute 'AsyncRun<bang> -cwd=' .
          \ fnameescape(FugitiveGitDir()) 'git pull' <q-args>

" ------------
" vim-dispatch
" ------------
" some CMake convenience functions
"function! CMakeConfigure()
"    Dispatch mkdir -p build
"    Dispatch cmake --configure -B build -S .
"    Dispatch ln -s build/compile_commands.json ./compile_commands.json
"endfunction
"nnoremap <F7> :call CMakeConfigure()<CR>
"
"function! CMakeClean()
"    Dispatch cmake --build build --target clean
"endfunction
"nnoremap <F6> :call CMakeClean()<CR>
"
"nnoremap <F5> :Make<CR>

" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Custom functions
" ----------------------------------------------------------------------------
" Status line ---
function! MyStatusLine()
    let statusline = ""
    " Name of the current branch (needs fugitive.vim)
    let statusline .= "%#PmenuSel#%{fugitive#statusline()}%#Pmenu#"
    " Filename (F -> full, f -> relative)
    let statusline .= "%f "
    " Left/right separator
    let statusline .= "%="
    " Buffer flags
    let statusline .= "%(%h%#Error#%m%*%r%w%)"
    " File format and type
    let statusline .= "(%{&enc}\/%{&ff}%(\/%Y%)) "
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



" Log
"
" g!/\v(\t-\>)|(PID: )|(SepM::OnCyc)|(^U  2024-)/d
" g!/\v^U  2024.*\n\s+|^\s+/d
" %s/\v^(U  2024\S+)[^\r\n]+\n(\s+[^\r\n]+)/\1\2/g
"
"
"
" g!/\v(\t-\>)|(PID: )|(SepM::OnCyc)|(^U  2024-)|warpTimeY|^(\s+[<>]{3}|\s+host|\s*\n)@!/d
" g!/\v^U  2024.*\n\s+|^\s+/d
" %s/\v^(U  2024\S+)[^\r\n]+\n(\s+[^\r\n]+)/\1\2/g
"
"function! LogDS3ShrinkAndAddTS()
"endfunction
" ---

" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Temporary fixes (e. g. to workaround missing Vim patches)
" ----------------------------------------------------------------------------

" Opening URLs via gx ---

" Doesn't work because of gh#vim/vim#4738
" let g:netrw_browsex_viewer='setsid osurl'
let g:netrw_nogx=1

" This is just temporary workaround until the above issue is truly
" resolved.
" https://github.com/vim/vim/issues/4738#issuecomment-830820565
" https://bugzilla.suse.com/show_bug.cgi?id=1173583
" (https://bugzilla.suse.com/show_bug.cgi?id=1173583)
" gh#vim/vim#4738
function! OpenURLUnderCursor()
  let s:uri = expand('<cfile>')
  echom "s:uri = " . s:uri
  if s:uri != ''
    echo s:uri
    silent exec "!start ".s:uri
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
" ---
" ----------------------------------------------------------------------------
