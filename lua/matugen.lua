 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#10131c',
    base01 = '#1c1f29',
    base02 = '#272a34',
    base03 = '#8a90a5',
    base04 = '#c0c6dd',
    base05 = '#e0e2ef',
    base06 = '#e0e2ef',
    base07 = '#e0e2ef',
    base08 = '#ffb4ab',
    base09 = '#b2c5ff',
    base0A = '#86d1ea',
    base0B = '#59d5f8',
    base0C = '#b2c5ff',
    base0D = '#59d5f8',
    base0E = '#86d1ea',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e0e2ef',          bg = '#10131c' })
  hi('TelescopeBorder',         { fg = '#8a90a5',             bg = '#10131c' })
  hi('TelescopePromptNormal',   { fg = '#e0e2ef',          bg = '#10131c' })
  hi('TelescopePromptBorder',   { fg = '#8a90a5',             bg = '#10131c' })
  hi('TelescopePromptPrefix',   { fg = '#59d5f8',             bg = '#10131c' })
  hi('TelescopePromptCounter',  { fg = '#c0c6dd',  bg = '#10131c' })
  hi('TelescopePromptTitle',    { fg = '#10131c',             bg = '#59d5f8' })
  hi('TelescopePreviewTitle',   { fg = '#10131c',             bg = '#86d1ea' })
  hi('TelescopeResultsTitle',   { fg = '#10131c',             bg = '#b2c5ff' })
  hi('TelescopeSelection',      { fg = '#e0e2ef',          bg = '#272a34' })
  hi('TelescopeSelectionCaret', { fg = '#59d5f8',             bg = '#272a34' })
  hi('TelescopeMatching',       { fg = '#59d5f8',             bold = true })
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
