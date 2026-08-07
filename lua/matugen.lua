 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#19120c',
    base01 = '#261e18',
    base02 = '#312822',
    base03 = '#9e8d82',
    base04 = '#d6c3b7',
    base05 = '#efdfd6',
    base06 = '#efdfd6',
    base07 = '#efdfd6',
    base08 = '#ffb4ab',
    base09 = '#c6cb96',
    base0A = '#e3c0a6',
    base0B = '#ffb77e',
    base0C = '#c6cb96',
    base0D = '#ffb77e',
    base0E = '#e3c0a6',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#efdfd6',          bg = '#19120c' })
  hi('TelescopeBorder',         { fg = '#9e8d82',             bg = '#19120c' })
  hi('TelescopePromptNormal',   { fg = '#efdfd6',          bg = '#19120c' })
  hi('TelescopePromptBorder',   { fg = '#9e8d82',             bg = '#19120c' })
  hi('TelescopePromptPrefix',   { fg = '#ffb77e',             bg = '#19120c' })
  hi('TelescopePromptCounter',  { fg = '#d6c3b7',  bg = '#19120c' })
  hi('TelescopePromptTitle',    { fg = '#19120c',             bg = '#ffb77e' })
  hi('TelescopePreviewTitle',   { fg = '#19120c',             bg = '#e3c0a6' })
  hi('TelescopeResultsTitle',   { fg = '#19120c',             bg = '#c6cb96' })
  hi('TelescopeSelection',      { fg = '#efdfd6',          bg = '#312822' })
  hi('TelescopeSelectionCaret', { fg = '#ffb77e',             bg = '#312822' })
  hi('TelescopeMatching',       { fg = '#ffb77e',             bold = true })
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
