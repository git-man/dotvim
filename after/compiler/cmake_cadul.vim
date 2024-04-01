let current_compiler = "cmake_cadul"
" :set mp=make\ \\\|&\ error_filter
" Work via default 'make' command but NOT Make/Dispatch
"CompilerSet makeprg=cmake\ --preset\ $*\ \&\&\ cmake\ --build\ --preset\ $*
"CompilerSet makeprg=cmake\ --preset\ $*\ --\ \&\&\ cmake\ --build\ --preset\ $*
"CompilerSet makeprg=cmake\ --preset\ $*\ \;\ \cmake\ \--build\ \--preset\ \$*
"CompilerSet makeprg=cmake\ --preset\ $*\ \\\|\ cmake\ \--build\ \--preset\ $*
"execute 'CompilerSet makeprg=cmake\ --preset\ $*\ \\\|\ cmake\ --build\ --preset\ $*'
"exe 'CompilerSet makeprg=perl\ -' . s:warnopt . s:taintopt . 'c\ %:S'
"	execute 'CompilerSet makeprg=zig\ build\ '.escape(g:zig_build_makeprg_params, ' \|"').'\ $*'
"	execute 'CompilerSet makeprg=cargo\ '.escape(g:cargo_makeprg_params, ' \|"').'\ $*'
"let &makeprg = "cmake --preset $* && cmake --build --preset $*"
CompilerSet makeprg=cmake\ --build\ --preset\ $*
"CompilerSet errorformat=CXX386-%t-%[A-Z]%\\+:%f:%l:%c:%m
"CompilerSet errorformat=
"      \%+A\ %#CXX386-%t-%[A-Z]%\\+:%f:%l:%c:\ %#%m,%Z\ %#%m,
"      \\ %#LINK386-%t-%[A-Z]%\\+%n:\ %#%m
CompilerSet errorformat=
      \CXX386-%t-%[A-Z]%\\+:\ %#%f\ %#:\ %#%l\ %#:\ %#%c\ %#:\ %#%m,
      \CXX386-%t-%[A-Z]%\\+:\ %#%f\ %#:\ %#%l\ %#:\ %#%m
