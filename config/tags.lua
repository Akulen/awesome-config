local awful			= require("awful")
local gears			= require("gears")
local lain			= require("lain")

--package.path = package.path .. ";/home/akulen/.config/awesome/modules/?.lua"
--package.path = package.path .. ";/home/akulen/.config/awesome/modules/?/init.lua"

local tyrannical

awful.client.property.persist("startup", "boolean")
awful.client.property.persist("disp", "string")

local tags = {}

if (#client.get() > 1 and client.get()[1].startup) then
	tyrannical = require("tyrannical")
else
	gears.timer.delayed_call(function() 
		tyrannical	= require("tyrannical")
		tyrannical.tags = tags.tags

		for _, c in ipairs(client.get()) do
			c:tags({c.screen.tags[11]})
		end
		for _, c in ipairs(client.get()) do
			disp = nil
			load("disp = " .. c.disp)()
			local ctags = {}
			for i, t in ipairs(disp.tags) do
				ctags[i] = c.screen.tags[t]
			end
			if(#ctags) then
				c:tags(ctags)
			end
		end
	end)
end

-- Table of layouts to cover with awful.layout.inc, order matters.
tags.layouts	=
{
	lain.layout.uselesstile,
	lain.layout.uselesstile.left,
	lain.layout.uselesstile.bottom,
	lain.layout.uselesstile.top,
	lain.layout.centerfair,
	lain.layout.centerworkd,
	lain.layout.uselesspiral,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	lain.layout.cascade,
	awful.layout.suit.floating
}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
local screens = {}
for s in screen do
	screens[s.index] = s.index
end
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
		init        = not(#client == 0),
		layout      = tags.layouts[1],
		volatile    = true,
		fallback    = true,
	},
}

if (#client.get() > 1 and client.get()[1].startup) then
	tyrannical.tags = tags.tags
end

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

return tags
