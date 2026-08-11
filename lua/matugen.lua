 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#f9faef',
    base01 = '#edefe4',
    base02 = '#e7e9de',
    base03 = '#74796d',
    base04 = '#44483e',
    base05 = '#1a1d16',
    base06 = '#1a1d16',
    base07 = '#1a1d16',
    base08 = '#ba1a1a',
    base09 = '#386664',
    base0A = '#57624a',
    base0B = '#49672e',
    base0C = '#a0cfcd',
    base0D = '#aed18c',
    base0E = '#becbae',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#1a1d16',          bg = '#f9faef' })
  hi('TelescopeBorder',         { fg = '#74796d',             bg = '#f9faef' })
  hi('TelescopePromptNormal',   { fg = '#1a1d16',          bg = '#f9faef' })
  hi('TelescopePromptBorder',   { fg = '#74796d',             bg = '#f9faef' })
  hi('TelescopePromptPrefix',   { fg = '#49672e',             bg = '#f9faef' })
  hi('TelescopePromptCounter',  { fg = '#44483e',  bg = '#f9faef' })
  hi('TelescopePromptTitle',    { fg = '#f9faef',             bg = '#49672e' })
  hi('TelescopePreviewTitle',   { fg = '#f9faef',             bg = '#57624a' })
  hi('TelescopeResultsTitle',   { fg = '#f9faef',             bg = '#386664' })
  hi('TelescopeSelection',      { fg = '#1a1d16',          bg = '#e7e9de' })
  hi('TelescopeSelectionCaret', { fg = '#49672e',             bg = '#e7e9de' })
  hi('TelescopeMatching',       { fg = '#49672e',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
