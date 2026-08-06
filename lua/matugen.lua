 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#13121c',
    base01 = '#1f1f29',
    base02 = '#2a2934',
    base03 = '#908ea5',
    base04 = '#c7c4dd',
    base05 = '#e4e0ef',
    base06 = '#e4e0ef',
    base07 = '#e4e0ef',
    base08 = '#ffb4ab',
    base09 = '#c3c0ff',
    base0A = '#91cef5',
    base0B = '#81cfff',
    base0C = '#c3c0ff',
    base0D = '#81cfff',
    base0E = '#91cef5',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e4e0ef',          bg = '#13121c' })
  hi('TelescopeBorder',         { fg = '#908ea5',             bg = '#13121c' })
  hi('TelescopePromptNormal',   { fg = '#e4e0ef',          bg = '#13121c' })
  hi('TelescopePromptBorder',   { fg = '#908ea5',             bg = '#13121c' })
  hi('TelescopePromptPrefix',   { fg = '#81cfff',             bg = '#13121c' })
  hi('TelescopePromptCounter',  { fg = '#c7c4dd',  bg = '#13121c' })
  hi('TelescopePromptTitle',    { fg = '#13121c',             bg = '#81cfff' })
  hi('TelescopePreviewTitle',   { fg = '#13121c',             bg = '#91cef5' })
  hi('TelescopeResultsTitle',   { fg = '#13121c',             bg = '#c3c0ff' })
  hi('TelescopeSelection',      { fg = '#e4e0ef',          bg = '#2a2934' })
  hi('TelescopeSelectionCaret', { fg = '#81cfff',             bg = '#2a2934' })
  hi('TelescopeMatching',       { fg = '#81cfff',             bold = true })
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
