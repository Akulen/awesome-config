local config	= {}

config.modkey	= "Mod4"

config.home				= "/home/akulen"
config.wallpaperfolder	= config.home .. "/Pictures/Backgrounds/"
config.themepath		= config.home .. "/.config/awesome/themes/solarized-dark/theme.lua"

-- Default app
config.terminal		= "termite"
config.editor		= os.getenv("EDITOR") or "vim"
config.editor_cmd	= config.terminal .. " -e " .. config.editor
config.browser		= "vivaldi-snapshot"

config.font	= "Terminus 12"

-- Variables
config.oneko	= false

return config
