" =============================================================================
" # NVIM CONFIGURATION
" =============================================================================

" Fish doesn't play all that well with others
set shell=/bin/bash

" Map space to leader
let mapleader = "\<Space>"

" Map jk to <esc>
inoremap jk <esc>
vnoremap jk <esc>

"{{{ Plugins
" Load vundle
set nocompatible
filetype off
call plug#begin()

" " VIM enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'

" GUI enhancements
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lukas-reineke/indent-blankline.nvim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" cmp-nvim extras
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()
" }}}

"{{{ LSP configuration
lua << END
  local lspconfig = require'lspconfig'
  local cmp = require'cmp'
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  cmp.setup({
    -- REQUIRED by nvim-cmp. TODO: get rid of it once we can
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
      -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
      { name = 'vsnip' },
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    experimental = {
      ghost_text = true,
    },
  })

  -- Use buffer source for `/`
  -- (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'path' }
    }
  })
  -- Use cmdline & path source for ':'
  -- (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)



    -- Get signatures (and _only_ signatures) when in argument lists.
    require "lsp_signature".on_attach({
      doc_lines = 0,
      handler_opts = {
        border = "none"
      },
    })
  end

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
    capabilities = capabilities,
  }

  lspconfig.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    }
  )
  -- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
  local signs = { Error = "x", Warning = "w", Hint = "h", Information = "i" }
  for type, icon in pairs(signs) do
      local hl = "LspDiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

END
"}}}

"{{{ Colors
augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight Comment ctermfg=8
  autocmd ColorScheme nord highlight Folded ctermfg=14
augroup END
colorscheme nord
" let g:airline_theme='nord'
let g:airline_theme='zenburn'
" }}}

"{{{ Plugin settings

let g:fzf_layout = { 'down': '~20%' }

" vim-rooter
" change directory to current buffer directory when no project detected
let g:rooter_change_directory_for_non_project_files = 'current'

" nord-vim
let g:nord_uniform_diff_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

let g:sneak#s_next = 1

let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" airline
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline_section_y = airline#section#create(['(%{bufnr("%")})'])
" let g:airline_section_b = airline#section#create(['%{StatuslineGit()}'])
let g:airline_section_z = airline#section#create(['%p%% ','%l:%c'])
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?' '.l:branchname.' ':''
" endfunction

" indentblankline
highlight IndentBlanklineChar ctermfg=0
nnoremap <leader>l :IndentBlanklineToggle<CR>
"}}}

"{{{ Editor settings
filetype plugin indent on

set autoindent    " maintain indent of current line
set smartindent   " try to auto-add indents where they make sense
set shiftround    " always indent by multiple of shiftwidth
set shiftwidth=2  " spaces per tab (when shifting)
set tabstop=2     " spaces per tab
set smarttab      " shiftwidth blanks at line start, softtabstop elsewhere
set expandtab     " use blanks instead of literal <Tab>s

set fcs=fold:\ ,vert:\| " remove the trailing dashes from foldtext
set foldmethod=syntax
" set foldmethod=marker
set foldlevel=0
set foldlevelstart=10
" set nofoldenable

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
" set completeopt=menuone,noinsert,noselect
set completeopt=menuone

" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300
" set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set hidden
" set nowrap
set nojoinspaces
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
" set signcolumn=yes
set signcolumn=number


" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.swp,*.o

" set omnifunc=syntaxcomplete#Complete

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase

" Automatic set current working directory to the buffer path
" set autochdir " vim.rooter plugin overrides this

set backspace=2 " Backspace over newlines
" set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=150
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
set list
"}}}

"{{{ Mappings

"Open and close all folds
nnoremap <silent> <leader>z zM
nnoremap <silent> <leader>Z zR

" show completion options
inoremap <C-n> <C-x><C-o>

" search files
nnoremap <C-p> :Files<CR>
" search buffers
nnoremap <C-b> :Buffers<CR>
" search text in files
nnoremap <C-l> :Rg<CR>

" Quick-save
nmap <leader>w :w<CR>
" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

noremap Y y$

" Store relative numbers jumps in the jumplist if they exceed a threshold
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"Replacing concurrences of the word under the cursor, one by one
nnoremap c* *Ncgn

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

"Open .vimrc in split window
nnoremap ,ev :vsplit $MYVIMRC<cr>

"Source .vimrc file
nnoremap ,sv :source $MYVIMRC<cr>

" Left and right can switch buffers
augroup buffer_nav
  nnoremap gb :bn<CR>
  nnoremap gB :bp<CR>
augroup END

" Move by line
nnoremap j gj
nnoremap k gk

set showtabline=0

"}}}

"{{{ Supporting files
" Backup files
" if !exists('g:myruntime')
"   let g:myruntime = split(&rtp, ',')[0]
" endif


if exists('$SUDO_USER')
  set nobackup      " don't create root-owned files
  set nowritebackup
  set noswapfile
else
  set backupdir=~/.config/nvim/tmp/backup/
  " set backupdir+=.
  set directory=~/.config/nvim/tmp/swap/
endif

" Persistent UNDO files
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/.config/nvim/tmp/undo//     " keep undo files out of the way
    " set undodir+=.
    set undofile                      " actually use undo files
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=             " don't create root-owned files
  else
    set viminfo+=n~/.config/nvim/tmp/viminfo " override ~/.viminfo default
  endif
endif

if has('mksession')
  set viewdir=~/.config/nvim/tmp/view " override ~/.vim/view default
  set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
endif
"}}}

"{{{ Functions
" =============================================================================
" <leader>s for Rg search
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {
"   \   'source': s:list_cmd(),
"   \   'options': '--tiebreak=index'},
"   \ <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {
  \   'options': '--tiebreak=index'},
  \ <bang>0)

function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+ '. repeat('-', 4) . line_text . ' ' . repeat('-', 4) . ' (' . folded_line_num . ' L)'
endfunction
set foldtext=MyFoldText()
"}}}

"{{{ Autocommands

" Enable type inline hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

autocmd FileType vim,txt setlocal foldmethod=marker
augroup vimFiletype
  autocmd!
  autocmd Syntax vim setlocal foldmethod=marker
  autocmd Filetype vim setlocal foldmethod=marker
augroup END

" Preserve folding when a file is reopened
augroup saveSession
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Show realtive number only on active buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"}}}

" =============================================================================
" # END
" =============================================================================
