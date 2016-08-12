-- TODO : split declarative declarations of the wibar and button definitions into separate config files and move back wibars.lua to modules/

local config		= require("config/base")
local menu			= require("config/menu")
local tags			= require("config/tags")

local awful			= require("awful")
local beautiful		= require("beautiful")
local gears			= require("gears")
local naughty		= require("naughty")
local vicious		= require("vicious")
local wibox			= require("wibox")

local APW			= require("modules/apw/widget")
local calendar		= require("modules/calendar35/init")
local orglendar		= require("modules/orglendar")

local ip			= require("widgets/ip")

local widgets = {}

function wibox.widget.textbox:vicious(args)
	local f = unpack or table.unpack -- Lua 5.1 compat
	vicious.register(self, f(args))
end

widgets.wibar_top			= {}
widgets.taglist				= {}
widgets.taglist.buttons 	= awful.util.table.join(
	awful.button({             }, 1, awful.tag.viewonly),
	awful.button({config.modkey}, 1, awful.client.movetotag),
	awful.button({             }, 3, awful.tag.viewtoggle),
	awful.button({config.modkey}, 3, awful.client.toggletag),
	awful.button({             }, 4,
		function(t)
			awful.tag.viewnext(awful.tag.getscreen(t))
		end),
	awful.button({             }, 5,
		function(t)
			awful.tag.viewprev(awful.tag.getscreen(t))
		end)
)
widgets.promptbox			= {}
widgets.infobar				= {}
widgets.wibar_bot			= {}
widgets.tasklist			= {}
widgets.tasklist.buttons	= awful.util.table.join(
	awful.button({             }, 1,
		function (c)
			if c == client.focus then
				c.minimized = true
			else
				-- Without this, the following :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() then awful.tag.viewonly(c:tags()[1]) end
				-- This will also un-minimize the client, if needed
				client.focus = c
				c:raise()
			end
		end),
	awful.button({             }, 3,
		function ()
			if instance then
				instance:hide()
				instance = nil
			else instance = awful.menu.clients({ theme = { width = 250 } }) end
		end),
	awful.button({             }, 4,
		function ()
			awful.client.focus.byidx(1)
			if client.focus then client.focus:raise() end
		end),
	awful.button({             }, 5,
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end)
)

for s = 1, screen.count() do
	widgets.promptbox[s]	= awful.widget.prompt()

	widgets.infobar[s]		= {
		{
			{
				{
					{
						vicious	= {vicious.widgets.fs, " ${/home used_gb}/${/home avail_gb} GB", 800},
						font	= config.font,
						widget	= wibox.widget.textbox
					},
					{
						{
							{
								{
									vicious	= {ip, "$1", 15},
									font	= config.font,
									widget	= wibox.widget.textbox
								},
								{
									{
										{
											APW,
											{
												{
													{
														vicious	= {vicious.widgets.date, "%b %d %R", 20},
														font	= config.font,
														widget	= wibox.widget.textbox,
														id		= "datewidget"
													},
													left	= 10,
													right	= 10,
													widget	= wibox.container.margin
												},
												shape				= gears.shape.hexagon,
												bg					= beautiful.colors.cyan,
												fg					= beautiful.colors.base03,
												--shape_border_color	= beautiful.border_color,
												--shape_border_width	= beautiful.border_width,
												widget				= wibox.container.background
											},
											widgets.cpuicon,
											{
												-- Battery widget for portable computer
												-- vicious	= {vicious.widgets.bat, "$1$2", 10, "BAT0"},
												vicious	= {vicious.widgets.cpu, "$1%", 5},
												font	= config.font,
												widget	= wibox.widget.textbox
											},
											layout	= wibox.layout.fixed.horizontal
										},
										left	= 10,
										right	= 10,
										widget	= wibox.container.margin
									},
									shape				= gears.shape.hexagon,
									bg					= beautiful.colors.blue,
									fg					= beautiful.colors.base03,
									--shape_border_color	= beautiful.border_color,
									--shape_border_width	= beautiful.border_width,
									widget				= wibox.container.background
								},
								widgets.memicon,
								{
									vicious	= {
										vicious.widgets.mem,
										function (widget, args)
											return args[1] .. "% (" .. math.floor(args[2] / 1024 + .5) .. "/" .. math.floor(args[3] / 1024 + .5) .. " GB)"
										end,
										13
									},
									font	= config.font,
									widget	= wibox.widget.textbox
								},
								widget	= wibox.layout.fixed.horizontal
							},
							left	= 10,
							right	= 10,
							widget	= wibox.container.margin
						},
						shape				= gears.shape.hexagon,
						bg					= beautiful.colors.violet,
						fg					= beautiful.colors.base03,
						--shape_border_color	= beautiful.border_color,
						--shape_border_width	= beautiful.border_width,
						widget				= wibox.container.background
					},
					{
						widget	= wibox.widget.systray,
					},
					widget	= wibox.layout.fixed.horizontal
				},
				left	= 10,
				right	= 10,
				widget	= wibox.container.margin
			},
			shape				= gears.shape.hexagon,
			bg					= beautiful.colors.dviolet,
			fg					= beautiful.colors.base03,
			--shape_border_color	= beautiful.border_color,
			--shape_border_width	= beautiful.border_width,
			widget				= wibox.container.background
		},
		layout = wibox.layout.fixed.horizontal	
	}
	
	awful.widget.layoutbox(s):buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc(tags.layouts, 1) end),
		awful.button({ }, 3, function () awful.layout.inc(tags.layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(tags.layouts, 1) end),
		awful.button({ }, 5, function () awful.layout.inc(tags.layouts, -1) end)
	))

	widgets.wibar_top[s]	= awful.wibar({ position = "top", screen = s })
	widgets.wibar_top[s] : setup {
		{
			{
				menu.launcher,
				awful.widget.taglist(
					s,
					awful.widget.taglist.filter.noempty,
					widgets.taglist.buttons
				),
				widgets.promptbox[s],
				layout	= wibox.layout.fixed.horizontal
			},
			nil,
			nil,
			layout	= wibox.layout.align.horizontal
		},
		{
			nil,
			widgets.infobar[s],
			nil,
			expand	= "none",
			layout	= wibox.layout.align.horizontal
		},
		{
			nil,
			nil,
			{
				awful.widget.layoutbox(s),
				layout = wibox.layout.fixed.horizontal
			},
			layout	= wibox.layout.align.horizontal
		},
		id		= "topbar",
	    layout	= wibox.layout.ratio.horizontal,
	}
	widgets.wibar_top[s].topbar:inc_ratio(2, 0.3)
	--calendar.addCalendarToWidget(widgets.wibar_top[s]:get_children_by_id("datewidget")[1])

	orglendar.files = { -- Specify here all files you want to be parsed, separated by comma.
		config.home .. "/TODO.org",
		--config.home .. "/Documents/Notes/work.org",
    	--config.home .. "/Documents/stuff/home.org"
	}
	orglendar.register(widgets.wibar_top[s]:get_children_by_id("datewidget")[1])

	widgets.wibar_bot[s]	= awful.wibar({ position = "bottom", screen = s })
	widgets.wibar_bot[s] : setup {
		nil,
		awful.widget.tasklist(
			s,
			awful.widget.tasklist.filter.currenttags,
			widgets.tasklist.buttons
		),
		nil,
		layout = wibox.layout.align.horizontal
	}

end

return widgets
