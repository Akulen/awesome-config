local config           = {}

--TODO
--config.revelation = require("config/revelation")

config.modkey          = "Mod4"

config.home            = "/home/akulen"
config.wallpaperfolder = config.home .. "/Pictures/tests/plop/"
config.themepath       = config.home .. "/.config/awesome/themes/solarized-dark/theme.lua"

-- Default app
config.terminal        = "termite"
config.Terminal        = "Termite"
config.editor          = os.getenv("EDITOR") or "vim"
config.editor_cmd      = config.terminal .. " -e " .. config.editor
config.browser         = "vivaldi-snapshot"

config.font            = "Terminus 12"

-- Variables
config.oneko           = false

return config
