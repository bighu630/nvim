 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fff8f6',
    base01 = '#fceae3',
    base02 = '#f6e5dd',
    base03 = '#85736b',
    base04 = '#52443d',
    base05 = '#221a15',
    base06 = '#221a15',
    base07 = '#221a15',
    base08 = '#ba1a1a',
    base09 = '#646032',
    base0A = '#765848',
    base0B = '#8d4e2a',
    base0C = '#cfc890',
    base0D = '#ffb690',
    base0E = '#e6beab',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#221a15',          bg = '#fff8f6' })
  hi('TelescopeBorder',         { fg = '#85736b',             bg = '#fff8f6' })
  hi('TelescopePromptNormal',   { fg = '#221a15',          bg = '#fff8f6' })
  hi('TelescopePromptBorder',   { fg = '#85736b',             bg = '#fff8f6' })
  hi('TelescopePromptPrefix',   { fg = '#8d4e2a',             bg = '#fff8f6' })
  hi('TelescopePromptCounter',  { fg = '#52443d',  bg = '#fff8f6' })
  hi('TelescopePromptTitle',    { fg = '#fff8f6',             bg = '#8d4e2a' })
  hi('TelescopePreviewTitle',   { fg = '#fff8f6',             bg = '#765848' })
  hi('TelescopeResultsTitle',   { fg = '#fff8f6',             bg = '#646032' })
  hi('TelescopeSelection',      { fg = '#221a15',          bg = '#f6e5dd' })
  hi('TelescopeSelectionCaret', { fg = '#8d4e2a',             bg = '#f6e5dd' })
  hi('TelescopeMatching',       { fg = '#8d4e2a',             bold = true })
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
