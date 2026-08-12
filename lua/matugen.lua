 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#f4fbfa',
    base01 = '#e9efee',
    base02 = '#e3e9e8',
    base03 = '#6f7978',
    base04 = '#3f4948',
    base05 = '#161d1c',
    base06 = '#161d1c',
    base07 = '#161d1c',
    base08 = '#ba1a1a',
    base09 = '#4b607c',
    base0A = '#4a6362',
    base0B = '#006a69',
    base0C = '#b2c8e8',
    base0D = '#80d5d3',
    base0E = '#b0cccb',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#161d1c',          bg = '#f4fbfa' })
  hi('TelescopeBorder',         { fg = '#6f7978',             bg = '#f4fbfa' })
  hi('TelescopePromptNormal',   { fg = '#161d1c',          bg = '#f4fbfa' })
  hi('TelescopePromptBorder',   { fg = '#6f7978',             bg = '#f4fbfa' })
  hi('TelescopePromptPrefix',   { fg = '#006a69',             bg = '#f4fbfa' })
  hi('TelescopePromptCounter',  { fg = '#3f4948',  bg = '#f4fbfa' })
  hi('TelescopePromptTitle',    { fg = '#f4fbfa',             bg = '#006a69' })
  hi('TelescopePreviewTitle',   { fg = '#f4fbfa',             bg = '#4a6362' })
  hi('TelescopeResultsTitle',   { fg = '#f4fbfa',             bg = '#4b607c' })
  hi('TelescopeSelection',      { fg = '#161d1c',          bg = '#e3e9e8' })
  hi('TelescopeSelectionCaret', { fg = '#006a69',             bg = '#e3e9e8' })
  hi('TelescopeMatching',       { fg = '#006a69',             bold = true })
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
