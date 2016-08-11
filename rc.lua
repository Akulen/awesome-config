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
-- Key Documentation
	require("modules/keydoc")
-- Sound library
	local APW			= require("modules/apw/widget")
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
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules	= {
	{ -- All clients will match this rule.
		rule		= {},
		properties	= {
			border_width		= beautiful.border_width,
			border_color		= beautiful.border_normal,
			focus				= awful.client.focus.filter,
			raise				= true,
			keys				= bindings.clientkeys,
			size_hints_honor	= false,
			buttons				= bindings.clientbuttons
		}
	},
	{
		rule		= {class	= "MPlayer"},
		properties	= {floating	= true}
	},
	{	rule		= {class	= "pinentry"},
		properties	= {floating	= true}
  	},
	{	rule		= {class	= "gimp"},
		properties	= {floating	= true}
	},
	-- Set Vivaldi to always map on tags number 1 of screen 1.
	{	rule		= {class	= config.browser},
		properties	= {tag		= tags.tags[1][1]}
	},
	{	rule		= {class	= "Skype"},
		properties	= {tag		= tags.tags[1][2]}
	},
	{	rule		= {class	= "Skype", name = "rigauto - Skype™"},
		properties	= {floating	= true}
	},
	{	rule		= {class	= "discord"},
		properties	= {tag		= tags.tags[1][2]}
	},
	{	rule		= {class	= "Clementine"},
		properties	= {tag		= tags.tags[1][10]}
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter",
		function(c)
			if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
				and awful.client.focus.filter(c) then
				client.focus = c
			end
		end
	)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	local titlebars_enabled = false
	if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
		-- buttons for the titlebar
		local buttons	= awful.util.table.join(
			awful.button({}, 1,
				function()
					client.focus = c
					c:raise()
					awful.mouse.client.move(c)
				end),
			awful.button({}, 3,
				function()
					client.focus = c
					c:raise()
					awful.mouse.client.resize(c)
				end)
		)

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(awful.titlebar.widget.iconwidget(c))
		left_layout:buttons(buttons)

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(awful.titlebar.widget.floatingbutton(c))
		right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		right_layout:add(awful.titlebar.widget.stickybutton(c))
		right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local middle_layout = wibox.layout.flex.horizontal()
		local title = awful.titlebar.widget.titlewidget(c)
		title:set_align("center")
		middle_layout:add(title)
		middle_layout:buttons(buttons)

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(middle_layout)

		awful.titlebar(c):set_widget(layout)
	end
end)

client.connect_signal("focus",
	function(c)
		c.border_color = beautiful.border_focus
	end
)
client.connect_signal("unfocus",
	function(c)
		c.border_color = beautiful.border_normal
	end
)
-- }}}

APWTimer = gears.timer({ timeout = 0.5 }) -- set update interval in s
APWTimer:connect_signal("timeout", APW.Update)
APWTimer:start()

-- Startup command /!\ MOVE TO .xinitrc

awful.spawn.with_shell("setxkbmap -option compose:ralt")
awful.spawn.with_shell("xcompmgr -C -f -D 3")
