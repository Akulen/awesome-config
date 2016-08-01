local config	= require("config/base")

local awful		= require("awful")
local beautiful	= require("beautiful")
beautiful.init(config.themepath)

local menu	= {}

menu.awesome		= {
	{ "manual",			config.terminal .. " -e man awesome" },
	{ "edit config",	config.editor_cmd .. " " .. awesome.conffile },
	{ "restart",		awesome.restart },
	{ "quit",			awesome.quit }
}
menu.quicklaunch	= {
	{ "&terminal",	config.terminal, beautiful.menu_terminal },
	{ "&vivaldi",	config.browser, beautiful.menu_vivaldi }
}
menu.menu			= awful.menu({
	items = {
		{ "awesome", menu.awesome, beautiful.awesome_icon },
		{ "&quick launch", menu.quicklaunch, beautiful.menu_launch }
	},
	theme = { width = 120 }
})
menu.launcher		= awful.widget.launcher({ image = beautiful.awesome_icon,
	menu = menu.menu })

return menu
