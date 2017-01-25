-- Load config
local config = require("config/base")

-- {{{ Standard awesome library
-- Gear
    local gears = require("gears")
-- Awful
    local awful = require("awful")
    require("awful.autofocus")
-- Theme handling library
    local beautiful = require("beautiful")
    -- Themes define colours, icons, font and wallpapers.
    beautiful.init(config.themepath)
-- Revelation
    local revelation = require("revelation")
    revelation.init(config.revelation)
-- }}}

-- {{{ Local Modules
-- Check errors
    require("modules/errors")
-- Sound library
    local APW = require("modules/apw/widget")
    APWTimer = gears.timer({ timeout = 0.5 }) -- set update interval in s
    APWTimer:connect_signal("timeout", APW.Update)
    APWTimer:start()
-- Wibars
    local wibars = require("config/wibars")
-- Bindings
    local bindings = require("config/bindings")
    root.buttons(bindings.mouse)
    root.keys(wibars.music:append_global_keys(bindings.globalkeys))
-- Signals
    require("config/signals")
-- }}}
