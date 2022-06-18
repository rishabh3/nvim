-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

local function hello()
  return [[hello world]]
end

-- Config
local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff','diagnostics'},
    lualine_c = {'%.80F'},
    lualine_x = {'encoding','fileformat','filetype'},
    lualine_y = {'progress', 'filesize'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
  },
  tabline = {},
  extensions = {}
}

-- Now don't forget to initialize lualine
lualine.setup(config)