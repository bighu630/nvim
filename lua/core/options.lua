local global = require("core.global")

local function load_options()
    local global_local = {
        termguicolors = true,
        mouse = "a",
        syntax = "on",
        errorbells = true,
        visualbell = true,
        hidden = true,
        title = true,
        fileformats = "unix,mac,dos",
        magic = true,
        virtualedit = "block",
        encoding = "utf-8",
        viewoptions = "folds,cursor,curdir,slash,unix",
        sessionoptions = "curdir,help,tabpages,winsize",
        clipboard = "unnamedplus",
        wildignorecase = true,
        wildignore =
        ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
        backup = false,
        writebackup = false,
        swapfile = false,
        undodir = global.cache_dir .. "undo/",
        directory = global.cache_dir .. "swap/",
        backupdir = global.cache_dir .. "backup/",
        viewdir = global.cache_dir .. "view/",
        spellfile = global.cache_dir .. "spell/en.uft-8.add",
        spelllang = "en_us,cjk",
        spell = true,
        history = 2000,
        shada = "!,'300,<50,@100,s10,h",
        backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
        smarttab = true,
        shiftround = true,
        timeout = true,
        ttimeout = true,
        timeoutlen = 500,
        ttimeoutlen = 0,
        updatetime = 100,
        redrawtime = 1500,
        ignorecase = true,
        smartcase = true,
        infercase = true,
        incsearch = true,
        wrapscan = true,
        wrap = true,
        complete = ".,w,b,k",
        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --hidden --vimgrep --smart-case --",
        breakat = [[\ \	;:,!?]],
        startofline = false,
        whichwrap = "h,l,<,>,[,],~",
        splitbelow = true,
        splitright = true,
        switchbuf = "useopen,uselast",
        backspace = "indent,eol,start",
        diffopt = "filler,iwhite,internal,algorithm:patience",
        completeopt = "menuone,noselect",
        jumpoptions = "stack",
        showmode = false,
        shortmess = "aoOTIcF",
        scrolloff = 5,
        sidescrolloff = 5,
        foldlevelstart = 99,
        ruler = true,
        cursorline = true,
        cursorcolumn = true,
        list = true,
        showtabline = 2,
        winwidth = 30,
        winminwidth = 10,
        pumheight = 15,
        helpheight = 12,
        previewheight = 12,
        showcmd = false,
        cmdheight = 0,
        cmdwinheight = 1,
        equalalways = false,
        laststatus = 2,
        display = "lastline",
        showbreak = "↳  ",
        -- listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
        listchars = "tab:│·,nbsp:+,trail:·,extends:→,precedes:←",
        -- pumblend = 10,
        -- winblend = 10,
        autoread = true,
        autowrite = true,

        undofile = true,
        synmaxcol = 2500,
        formatoptions = "1jcroql",
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        breakindentopt = "shift:2,min:20",
        wrap = false,
        linebreak = true,
        number = true,
        relativenumber = true,
        -- foldenable = true,
        foldmethod = "expr", -- fold with nvim_treesitter
        foldexpr = "nvim_treesitter#foldexpr()",
        foldenable = false,  -- no fold to be applied when open a file
        foldlevel = 99,      -- if not set this, fold will be everywhere
        signcolumn = "yes",
        conceallevel = 0,
        concealcursor = "niv",
        foldmethod = "expr", -- fold with nvim_treesitter

        -- add by myself
    }

    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
            paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
            cache_enabled = 0,
        }
        vim.g.python_host_prog = "/usr/bin/python"
        vim.g.python3_host_prog = "/usr/local/bin/python3"
    else
        vim.g.python_host_prog = "/usr/bin/python"
        vim.g.python3_host_prog = "/usr/bin/python3"
    end
    for name, value in pairs(global_local) do
        vim.o[name] = value
    end
end

local function set_sidebar_icons()
    local diagnostic_icons = {
        Error = " ",
        Warn = " ",
        Info = " ",
        Hint = " ",
    }
    for type, icon in pairs(diagnostic_icons) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
end

set_sidebar_icons()
load_options()
