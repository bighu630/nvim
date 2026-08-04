 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0d141b',
    base01 = '#192028',
    base02 = '#242b33',
    base03 = '#8492a3',
    base04 = '#bac8da',
    base05 = '#dce3ee',
    base06 = '#dce3ee',
    base07 = '#dce3ee',
    base08 = '#ffb4ab',
    base09 = '#9dcbfc',
    base0A = '#80d4d8',
    base0B = '#4cd9df',
    base0C = '#9dcbfc',
    base0D = '#4cd9df',
    base0E = '#80d4d8',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#dce3ee',          bg = '#0d141b' })
  hi('TelescopeBorder',         { fg = '#8492a3',             bg = '#0d141b' })
  hi('TelescopePromptNormal',   { fg = '#dce3ee',          bg = '#0d141b' })
  hi('TelescopePromptBorder',   { fg = '#8492a3',             bg = '#0d141b' })
  hi('TelescopePromptPrefix',   { fg = '#4cd9df',             bg = '#0d141b' })
  hi('TelescopePromptCounter',  { fg = '#bac8da',  bg = '#0d141b' })
  hi('TelescopePromptTitle',    { fg = '#0d141b',             bg = '#4cd9df' })
  hi('TelescopePreviewTitle',   { fg = '#0d141b',             bg = '#80d4d8' })
  hi('TelescopeResultsTitle',   { fg = '#0d141b',             bg = '#9dcbfc' })
  hi('TelescopeSelection',      { fg = '#dce3ee',          bg = '#242b33' })
  hi('TelescopeSelectionCaret', { fg = '#4cd9df',             bg = '#242b33' })
  hi('TelescopeMatching',       { fg = '#4cd9df',             bold = true })
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
