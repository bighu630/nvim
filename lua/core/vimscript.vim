let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx5-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx5-remote -c")
    endif
endfunction

function! Fcitx2zh()
    if expand("%:e")== "md"
        let s:input_status = system("fcitx5-remote")
        if s:input_status != 2 && g:input_toggle == 1
            let l:a = system("fcitx5-remote -o")
            let g:input_toggle = 0
        endif
    endif
endfunction

"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式

autocmd FileType Outline setlocal signcolumn=no

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd VimLeave !pkill gopls

" filetype
au BufNewFile,BufRead config set filetype=i3config
au BufNewFile,BufRead .conkyrc set filetype=conkyrc

augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'lang.jdt'.lang_java()
augroup end

augroup _load_break_points
    autocmd!
    autocmd FileType c,cpp,go,python,lua,java :lua require('dap.dap-util').load_breakpoints()
augroup end

" auto format on save
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END

" git highlight
function! ConflictsHighlight() abort
    syn region conflictStart start=/^<<<<<<< .*$/ end=/^\ze\(=======$\||||||||\)/
    syn region conflictMiddle start=/^||||||| .*$/ end=/^\ze=======$/
    syn region conflictEnd start=/^\(=======$\||||||| |\)/ end=/^>>>>>>> .*$/

    highlight conflictStart ctermbg=red ctermfg=black
    highlight conflictMiddle ctermbg=blue ctermfg=black
    highlight conflictEnd ctermbg=green cterm=bold ctermfg=black
endfunction

augroup MyColors
    autocmd!
    autocmd BufEnter * call ConflictsHighlight()
augroup END


" 设置颜色
colorscheme catppuccin-mocha
set colorcolumn=88
