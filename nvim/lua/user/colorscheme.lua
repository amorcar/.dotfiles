vim.cmd [[

augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight Comment ctermfg=8
  autocmd ColorScheme nord highlight Folded ctermfg=14
augroup END

colorscheme nord

" let g:airline_theme='nord'
let g:airline_theme='zenburn'

]]
