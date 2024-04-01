let current_compiler = "cmake_pclint"

CompilerSet makeprg=cmake\ --build\ --preset\ $*
CompilerSet errorformat=
      \%f:%l:%c\ %#%t%[A-Za-z]%#\ %#PC-lint(%n):\ %#%m,
      \%t%[A-Za-z]%#\ %#PC-lint(%n):\ %#%m
