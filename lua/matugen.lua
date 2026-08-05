 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0c141b',
    base01 = '#192028',
    base02 = '#232b32',
    base03 = '#8392a3',
    base04 = '#b8c8da',
    base05 = '#dce3ed',
    base06 = '#dce3ed',
    base07 = '#dce3ed',
    base08 = '#ffb4ab',
    base09 = '#99ccfa',
    base0A = '#80d5d3',
    base0B = '#4ddad9',
    base0C = '#99ccfa',
    base0D = '#4ddad9',
    base0E = '#80d5d3',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#dce3ed',          bg = '#0c141b' })
  hi('TelescopeBorder',         { fg = '#8392a3',             bg = '#0c141b' })
  hi('TelescopePromptNormal',   { fg = '#dce3ed',          bg = '#0c141b' })
  hi('TelescopePromptBorder',   { fg = '#8392a3',             bg = '#0c141b' })
  hi('TelescopePromptPrefix',   { fg = '#4ddad9',             bg = '#0c141b' })
  hi('TelescopePromptCounter',  { fg = '#b8c8da',  bg = '#0c141b' })
  hi('TelescopePromptTitle',    { fg = '#0c141b',             bg = '#4ddad9' })
  hi('TelescopePreviewTitle',   { fg = '#0c141b',             bg = '#80d5d3' })
  hi('TelescopeResultsTitle',   { fg = '#0c141b',             bg = '#99ccfa' })
  hi('TelescopeSelection',      { fg = '#dce3ed',          bg = '#232b32' })
  hi('TelescopeSelectionCaret', { fg = '#4ddad9',             bg = '#232b32' })
  hi('TelescopeMatching',       { fg = '#4ddad9',             bold = true })
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
