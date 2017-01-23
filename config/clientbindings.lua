local config   = require("config/base")

local awful    = require("awful")

local bindings = {}

bindings.keys        = awful.util.table.join(
    awful.key({config.modkey,          }, "f",
        function (c)
            c.fullscreen = not c.fullscreen 
            c:raise()
        end,
        {description = "toggle fullscreen", group = "Window-specific bindings"}),
    awful.key({config.modkey, "Shift"  }, "c",
        function (c)
            c:kill()
        end,
        {description = "close", group = "Window-specific bindings"}),
    awful.key({config.modkey, "Control"}, "space",  awful.client.floating.toggle,
        {description = "toggle floating", group = "Window-specific bindings"}),
    awful.key({config.modkey, "Control"}, "Return",
        function (c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "Window-specific bindings"}),
    awful.key({config.modkey,          }, "o",      awful.client.movetoscreen,
        {description = "move to screen", group = "Window-specific bindings"}),
    awful.key({config.modkey, "Shift"  }, "t",
        function (c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "Window-specific bindings"}),
    awful.key({config.modkey,          }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "Window-specific bindings"}),
    awful.key({ config.modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
        end,
        {description = "maximise", group = "Window-specific bindings"})
)

bindings.buttons    = awful.util.table.join(
    awful.button({                         }, 1,
        function (c)
            client.focus = c
            c:raise()
        end),
    awful.button({config.modkey,           }, 1, awful.mouse.client.move),
    awful.button({config.modkey,           }, 3, awful.mouse.client.resize)
)

return bindings
