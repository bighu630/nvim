 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#111318',
    base01 = '#1e1f25',
    base02 = '#282a2f',
    base03 = '#8e9099',
    base04 = '#c4c6d0',
    base05 = '#e2e2e9',
    base06 = '#e2e2e9',
    base07 = '#e2e2e9',
    base08 = '#ffb4ab',
    base09 = '#debcdf',
    base0A = '#bfc6dc',
    base0B = '#adc6ff',
    base0C = '#debcdf',
    base0D = '#adc6ff',
    base0E = '#bfc6dc',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e2e2e9',          bg = '#111318' })
  hi('TelescopeBorder',         { fg = '#8e9099',             bg = '#111318' })
  hi('TelescopePromptNormal',   { fg = '#e2e2e9',          bg = '#111318' })
  hi('TelescopePromptBorder',   { fg = '#8e9099',             bg = '#111318' })
  hi('TelescopePromptPrefix',   { fg = '#adc6ff',             bg = '#111318' })
  hi('TelescopePromptCounter',  { fg = '#c4c6d0',  bg = '#111318' })
  hi('TelescopePromptTitle',    { fg = '#111318',             bg = '#adc6ff' })
  hi('TelescopePreviewTitle',   { fg = '#111318',             bg = '#bfc6dc' })
  hi('TelescopeResultsTitle',   { fg = '#111318',             bg = '#debcdf' })
  hi('TelescopeSelection',      { fg = '#e2e2e9',          bg = '#282a2f' })
  hi('TelescopeSelectionCaret', { fg = '#adc6ff',             bg = '#282a2f' })
  hi('TelescopeMatching',       { fg = '#adc6ff',             bold = true })
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
