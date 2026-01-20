local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Catppuccin Frappe'

config.freetype_load_flags = 'NO_HINTING'
config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 16

return config
