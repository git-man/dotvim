let current_compiler = "clang"
CompilerSet makeprg=cmake\ --build\ --preset\ $*
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
