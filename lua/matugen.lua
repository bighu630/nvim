 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fcf8ff',
    base01 = '#f0ecf4',
    base02 = '#eae7ef',
    base03 = '#787680',
    base04 = '#47464f',
    base05 = '#1b1b21',
    base06 = '#1b1b21',
    base07 = '#1b1b21',
    base08 = '#ba1a1a',
    base09 = '#7a5368',
    base0A = '#5e5c71',
    base0B = '#5a5892',
    base0C = '#eab9d1',
    base0D = '#c3c0ff',
    base0E = '#c7c4dd',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#1b1b21',          bg = '#fcf8ff' })
  hi('TelescopeBorder',         { fg = '#787680',             bg = '#fcf8ff' })
  hi('TelescopePromptNormal',   { fg = '#1b1b21',          bg = '#fcf8ff' })
  hi('TelescopePromptBorder',   { fg = '#787680',             bg = '#fcf8ff' })
  hi('TelescopePromptPrefix',   { fg = '#5a5892',             bg = '#fcf8ff' })
  hi('TelescopePromptCounter',  { fg = '#47464f',  bg = '#fcf8ff' })
  hi('TelescopePromptTitle',    { fg = '#fcf8ff',             bg = '#5a5892' })
  hi('TelescopePreviewTitle',   { fg = '#fcf8ff',             bg = '#5e5c71' })
  hi('TelescopeResultsTitle',   { fg = '#fcf8ff',             bg = '#7a5368' })
  hi('TelescopeSelection',      { fg = '#1b1b21',          bg = '#eae7ef' })
  hi('TelescopeSelectionCaret', { fg = '#5a5892',             bg = '#eae7ef' })
  hi('TelescopeMatching',       { fg = '#5a5892',             bold = true })
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
