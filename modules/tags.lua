local lain	= require("lain")
local awful	= require("awful")

local tags = {}

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
tags.tags	= {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags.tags[s] = awful.tag({ '', '', 3, 4, 5, 6, 7, 8, '' }, s, tags.layouts[1])
end
-- }}}

awful.layout.set(lain.layout.cascade, tags.tags[1][1])

return tags
