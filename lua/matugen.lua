 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#24273a',
    base01 = '#363a4f',
    base02 = '#3e435b',
    base03 = '#6e738d',
    base04 = '#a5adcb',
    base05 = '#cad3f5',
    base06 = '#cad3f5',
    base07 = '#cad3f5',
    base08 = '#ed8796',
    base09 = '#91d7e3',
    base0A = '#8aadf4',
    base0B = '#7dc4e4',
    base0C = '#96dde9',
    base0D = '#95cfe9',
    base0E = '#8aadf4',
    base0F = '#b70b24',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#cad3f5',          bg = '#24273a' })
  hi('TelescopeBorder',         { fg = '#6e738d',             bg = '#24273a' })
  hi('TelescopePromptNormal',   { fg = '#cad3f5',          bg = '#24273a' })
  hi('TelescopePromptBorder',   { fg = '#6e738d',             bg = '#24273a' })
  hi('TelescopePromptPrefix',   { fg = '#7dc4e4',             bg = '#24273a' })
  hi('TelescopePromptCounter',  { fg = '#a5adcb',  bg = '#24273a' })
  hi('TelescopePromptTitle',    { fg = '#24273a',             bg = '#7dc4e4' })
  hi('TelescopePreviewTitle',   { fg = '#24273a',             bg = '#8aadf4' })
  hi('TelescopeResultsTitle',   { fg = '#24273a',             bg = '#91d7e3' })
  hi('TelescopeSelection',      { fg = '#cad3f5',          bg = '#3e435b' })
  hi('TelescopeSelectionCaret', { fg = '#7dc4e4',             bg = '#3e435b' })
  hi('TelescopeMatching',       { fg = '#7dc4e4',             bold = true })
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
