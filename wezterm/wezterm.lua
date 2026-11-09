local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Set the font size (in points)
config.font_size = 15.0
config.font = wezterm.font 'Menlo'

return config

