let current_compiler = "cmake_clang"
CompilerSet makeprg=cmake\ --build\ $*
"CompilerSet errorformat=%f%l%c:\ %t%s:\ %m
CompilerSet errorformat=
  \%A%f:%l:%c:\ %#%t%[a-z]%\\+:\ %#%m,
  \%-C%.%#,
  \%-C%p^,
  \%-Z%m,
  \%-G%.%#,
  \%-A[%\\d%\\+/%\\d%\\+]%.%#,
  \%-Z%.%#,
  \%-G%.%#
