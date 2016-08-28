-- Load config
local config			= require("config/base")

-- {{{ Standard awesome library
-- Gear
	local gears			= require("gears")
-- Awful
	local awful			= require("awful")
	awful.rules			= require("awful.rules")
	require("awful.autofocus")
-- Widget and layout library
	local wibox			= require("wibox")
-- Theme handling library
	local beautiful		= require("beautiful")
	-- Themes define colours, icons, font and wallpapers.
	beautiful.init(config.themepath)
-- Notification library
	local naughty		= require("naughty")
-- Revelation
	local revelation	= require("revelation")
	revelation.init(config.revelation)
-- Vicious
	local vicious		= require("vicious")
-- Lain
	local lain			= require("lain")
-- }}}

-- {{{ Local Modules
-- Check errors
	require("modules/errors")
-- Sound library
	local APW			= require("modules/apw/widget")
	APWTimer = gears.timer({ timeout = 0.5 }) -- set update interval in s
	APWTimer:connect_signal("timeout", APW.Update)
	APWTimer:start()
-- Wallpaper
	local wp			= require("modules/wallpaper")
	if beautiful.wallpaper then
		for s = 1, screen.count() do
			gears.wallpaper.maximized(beautiful.wallpaper, s, true)
		end
	end
	-- initial start when rc.lua is first run
	wp.timer:start()
-- Tags
	local tags		= require("config/tags") 
-- Bindings
	local bindings	= require("config/bindings")
	root.buttons(bindings.mouse)
	root.keys(bindings.globalkeys)
-- Signals
	require("config/signals")
-- }}}
