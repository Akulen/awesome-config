local config = require("config/base")

local awful  = require("awful")

require("modules/keydoc")

local bindings = {}

bindings.keys		= awful.util.table.join(
	keydoc.group("Window-specific bindings"),
		awful.key({config.modkey,          }, "f",
			function (c)
				c.fullscreen = not c.fullscreen 
			end,
			"Fullscreen"),
		awful.key({config.modkey, "Shift"  }, "c",
			function (c)
				c:kill()
			end),
		awful.key({config.modkey, "Control"}, "space",  awful.client.floating.toggle, "Toggle floating"),
		awful.key({config.modkey, "Control"}, "Return",
			function (c)
				c:swap(awful.client.getmaster())
			end,
			"Switch with master window"),
		awful.key({config.modkey,          }, "o",      awful.client.movetoscreen,    "Move to the other screen"),
		awful.key({config.modkey, "Shift"  }, "t",
			function (c)
				c.ontop = not c.ontop
			end,
			"Raise window"),
		awful.key({config.modkey,          }, "n",
			function (c)
				-- The client currently has the input focus, so it cannot be
				-- minimized, since minimized clients can't have the focus.
				c.minimized = true
			end),
		awful.key({ config.modkey,           }, "m",
			function (c)
				c.maximized_horizontal = not c.maximized_horizontal
				c.maximized_vertical   = not c.maximized_vertical
			end, "Maximise")
)

bindings.buttons	= awful.util.table.join(
	awful.button({                         }, 1,
		function (c)
			client.focus = c
			c:raise()
		end),
	awful.button({config.modkey,           }, 1, awful.mouse.client.move),
	awful.button({config.modkey,           }, 3, awful.mouse.client.resize)
)

return bindings
