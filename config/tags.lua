local awful      = require("awful")
local beautiful  = require("beautiful")
local gears      = require("gears")
local lain       = require("lain")

local tyrannical = require("tyrannical")

local bindings   = {client = require("config/clientbindings")}

--package.path = package.path .. ";/home/akulen/.config/awesome/modules/?.lua"
--package.path = package.path .. ";/home/akulen/.config/awesome/modules/?/init.lua"

local tags = { properties = {} }

awful.rules.rules = {
	{ -- All clients will match this rule.
		rule       = {},
		properties = {
			border_width     = beautiful.border_width,
			border_color     = beautiful.border_normal,
			focus            = awful.client.focus.filter,
			raise            = true,
			keys             = bindings.client.keys,
			buttons          = bindings.client.buttons,
            screen           = awful.screen.preferred,
            placement        = awful.placement.no_overlap+awful.placement.no_offscreen
		},
	},
	{
		rule       = {class    = "Gimp"},
		except_any = {role     = {"gimp-image-window", "gimp-file-open"}},
		properties = {floating = false},
		callback   = awful.client.setslave,
	},
	{
		rule     = {class = "Gimp"},
		callback = function(c)
			c.screen.selected_tag.layout = lain.layout.centerworkd
		end,
	},
}

-- Table of layouts to cover with awful.layout.inc, order matters.
tags.layouts	=
{
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--lain.layout.centerfair,
	--lain.layout.centerworkd,
	--lain.layout.uselesspiral,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
	lain.layout.cascade,
	awful.layout.suit.floating
}

awful.layout.layouts = tags.layouts

-- {{{ Tags
--{'', '', 3, 4, 5, 6, 7, 8, '9', ''},
tags.tags = {
	{
		name        = "",
		init        = true,
		exclusive   = true,                   -- Refuse any other type of clients (by classes)
		screen      = screens,
		layout      = lain.layout.cascade,
		class       = {"vivaldi-snapshot"},
		selected    = true
	},
	{
		name        = "",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1],
		class       = {"Ghetto Skype", "discord"}
	},
	{
		name        = "3",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "4",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "5",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "6",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "7",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "8",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "9",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "",
		init        = true,
		screen      = screens,
		layout      = tags.layouts[1]
	},
	{
		name        = "Extras",
		init        = not(#client.get() == 0),
		layout      = tags.layouts[1],
		volatile    = true,
		fallback    = true,
	},
}

--TODO
tags.properties.floating = {
    "MPlayer",
}

--tags.tags	= {}
--for s = 1, screen.count() do
--	-- Each screen has its own tag table - The icons require awesome font and ionicon font.
--	tags.tags[s]	= {{}, {}}
--	local icons		= {
--		{'', '', 3, 4, 5, 6, 7, 8, '9', ''},
--		{'1', '2', 3, 4, 5, 6, 7, 8, '9', '0'}
--	}
--	for t = 1, 10 do
--		tags.tags[s][1][t] = awful.tag.add(icons[1][t], {
--			screen		= s,
--			layout		= tags.layouts[1]
--		})
--		tags.tags[s][2][t] = awful.tag.add(icons[2][t], {
--			screen		= s,
--			layout		= tags.layouts[1],
--			activated	= false
--		})
--	end
--end
---- }}}
--
--tags.tags[1][1][1].selected = true
--tags.tags[1][1][1].layout = lain.layout.cascade
--tags.current = 1

tyrannical.tags = tags.tags

return tags
