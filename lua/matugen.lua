 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1c1108',
    base01 = '#2a1d13',
    base02 = '#35271d',
    base03 = '#aa8a73',
    base04 = '#e3c0a6',
    base05 = '#f7dece',
    base06 = '#f7dece',
    base07 = '#f7dece',
    base08 = '#ffb4ab',
    base09 = '#ffb77e',
    base0A = '#ffb2bf',
    base0B = '#ffb2bf',
    base0C = '#ffb77e',
    base0D = '#ffb2bf',
    base0E = '#ffb2bf',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f7dece',          bg = '#1c1108' })
  hi('TelescopeBorder',         { fg = '#aa8a73',             bg = '#1c1108' })
  hi('TelescopePromptNormal',   { fg = '#f7dece',          bg = '#1c1108' })
  hi('TelescopePromptBorder',   { fg = '#aa8a73',             bg = '#1c1108' })
  hi('TelescopePromptPrefix',   { fg = '#ffb2bf',             bg = '#1c1108' })
  hi('TelescopePromptCounter',  { fg = '#e3c0a6',  bg = '#1c1108' })
  hi('TelescopePromptTitle',    { fg = '#1c1108',             bg = '#ffb2bf' })
  hi('TelescopePreviewTitle',   { fg = '#1c1108',             bg = '#ffb2bf' })
  hi('TelescopeResultsTitle',   { fg = '#1c1108',             bg = '#ffb77e' })
  hi('TelescopeSelection',      { fg = '#f7dece',          bg = '#35271d' })
  hi('TelescopeSelectionCaret', { fg = '#ffb2bf',             bg = '#35271d' })
  hi('TelescopeMatching',       { fg = '#ffb2bf',             bold = true })
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
