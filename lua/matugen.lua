 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#f7f9ff',
    base01 = '#eceef3',
    base02 = '#e6e8ee',
    base03 = '#72777f',
    base04 = '#42474e',
    base05 = '#181c20',
    base06 = '#181c20',
    base07 = '#181c20',
    base08 = '#ba1a1a',
    base09 = '#68587a',
    base0A = '#51606f',
    base0B = '#2f628c',
    base0C = '#d3bfe6',
    base0D = '#9bcbfa',
    base0E = '#b9c8da',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#181c20',          bg = '#f7f9ff' })
  hi('TelescopeBorder',         { fg = '#72777f',             bg = '#f7f9ff' })
  hi('TelescopePromptNormal',   { fg = '#181c20',          bg = '#f7f9ff' })
  hi('TelescopePromptBorder',   { fg = '#72777f',             bg = '#f7f9ff' })
  hi('TelescopePromptPrefix',   { fg = '#2f628c',             bg = '#f7f9ff' })
  hi('TelescopePromptCounter',  { fg = '#42474e',  bg = '#f7f9ff' })
  hi('TelescopePromptTitle',    { fg = '#f7f9ff',             bg = '#2f628c' })
  hi('TelescopePreviewTitle',   { fg = '#f7f9ff',             bg = '#51606f' })
  hi('TelescopeResultsTitle',   { fg = '#f7f9ff',             bg = '#68587a' })
  hi('TelescopeSelection',      { fg = '#181c20',          bg = '#e6e8ee' })
  hi('TelescopeSelectionCaret', { fg = '#2f628c',             bg = '#e6e8ee' })
  hi('TelescopeMatching',       { fg = '#2f628c',             bold = true })
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
