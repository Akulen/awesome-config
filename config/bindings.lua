local config			= require("config/base")

local awful				= require("awful")
local revelation		= require("revelation")

local APW				= require("modules/apw/widget")
local menu				= require("config/menu")
local ror				= require("modules/aweror")
local tags				= require("config/tags")
local utils				= require("modules/utils")
local wibars			= require("config/wibars")
local wp				= require("modules/wallpaper")

local bindings			= {}

-- Mouse bindings
bindings.mouse			= awful.util.table.join(
	awful.button({ }, 3, function () menu.menu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)

-- Key bindings
bindings.globalkeys		= awful.util.table.join(
	keydoc.group("Tag management"),
		awful.key({config.modkey, "Control"}, "t",
			function()
				local s = awful.screen.focused()
				--local curTag = s.selected_tag.index
				for t = 1, 10 do
					tags.tags[s.index][tags.current][t].activated = false
					tags.tags[s.index][3 - tags.current][t].activated = true
				end
				tags.current = 3 - tags.current
				--tags.tags[s.index][tags.current][curTag].selected = true
				tags.tags[s.index][tags.current][1].selected = true
			end,
			"Switch tag bars"),
		awful.key({config.modkey,          }, "Left",   awful.tag.viewprev       , "Next tag"),
		awful.key({config.modkey,          }, "Right",  awful.tag.viewnext       , "Previous tag"),
		awful.key({config.modkey,          }, "Escape", awful.tag.history.restore, "Switch to previous tag"),
		awful.key({config.modkey,          }, "e",
			function()
				revelation({rule = {class = config.Terminal}})
			end,
			"Revelation"),
		awful.key({config.modkey,          }, "b",
			function()
				wp.timer:emit_signal("timeout")
			end,
			"Swap Wallpaper"),
		awful.key({config.modkey, "Shift"  }, "b",
			function ()
				if wp.config.freeze == false then
					wp.timer:stop()
				else
					wp.timer:start()
				end
				wp.config.freeze = not wp.config.freeze
			end,
			"Freeze Wallpaper swapper"),
	
	keydoc.group("Focus"),
		awful.key({config.modkey,          }, "j",
			function ()
				awful.client.focus.byidx(1)
				if client.focus then client.focus:raise() end
			end,
			"Focus next window"),
		awful.key({config.modkey,          }, "k",
			function ()
				awful.client.focus.byidx(-1)
				if client.focus then client.focus:raise() end
			end,
			"Focus previous window"),
		awful.key({config.modkey,          }, "w",
			function ()
				menu.menu:show()
			end),

	-- Layout manipulation
	keydoc.group("Layout manipulation"),
		awful.key({config.modkey,          }, "l",
			function ()
				awful.tag.incmwfact(0.05)
			end,
			"Increase master-width factor"),
		awful.key({config.modkey,          }, "h",
			function ()
				awful.tag.incmwfact(-0.05)
			end,
			"Decrease master-width factor"),
		awful.key({config.modkey, "Shift"  }, "l",
			function ()
				awful.tag.incnmaster(1)
			end,
			"Increase number of masters"),
		awful.key({config.modkey, "Shift"  }, "h",
			function ()
				awful.tag.incnmaster(-1)
			end,
			"Decrease number of masters"),
		awful.key({config.modkey, "Control"}, "l",
			function ()
				awful.tag.incncol(1)
			end,
			"Increase number of columns"),
		awful.key({config.modkey, "Control"}, "h",
			function ()
				awful.tag.incncol(-1)
			end,
			"Decrease number of columns"),
		awful.key({config.modkey,          }, "space",
			function ()
				awful.layout.inc(tags.layouts, 1)
			end,
			"Next layout"),
		awful.key({config.modkey, "Shift"  }, "space",
			function ()
				awful.layout.inc(tags.layouts, -1)
			end,
			"Previous layout"),
		awful.key({config.modkey, "Shift"  }, "j",
			function ()
				awful.client.swap.byidx(1)
			end,
			"Swap with next window"),
		awful.key({config.modkey, "Shift"  }, "k",
			function ()
				awful.client.swap.byidx(-1)
			end,
			"Swap with previous window"),
		awful.key({config.modkey, "Control"}, "j",
			function ()
				awful.screen.focus_relative(1)
			end),
		awful.key({config.modkey, "Control"}, "k",
			function ()
				awful.screen.focus_relative(-1)
			end),
		awful.key({config.modkey,          }, "u", awful.client.urgent.jumpto),
		awful.key({}, "XF86MonBrightnessDown",
			function ()
				awful.spawn("xbacklight -dec 10")
			end),
		awful.key({}, "XF86MonBrightnessUp",
			function ()
				awful.spawn("xbacklight -inc 10")
			end),
		awful.key({config.modkey,          }, "Tab",
			function ()
				awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end, "Focus previously focused window"),

		awful.key({config.modkey, "Control"}, "n", awful.client.restore),

	-- Standard program
	keydoc.group("Misc"),
		awful.key({config.modkey,          }, "Return",
			function ()
				awful.spawn(config.terminal)
			end),
		awful.key({config.modkey,          }, "t",
			function ()
				awful.spawn(config.terminal)
			end,
			"Spawn a terminal"),
		awful.key({}, "Print",
			function ()
				awful.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'")
			end),
		awful.key({config.modkey, "Control"}, "r",
			function()
				-- Serialize client tag data
				--awful.client.property.persist("disp", "string")
				for _, c in ipairs(client.get()) do
					local screen = c.screen.index
					local ctags = {}
					for i, t in ipairs(c:tags()) do
						ctags[i] = t.index
					end
					c.disp = utils.serialise({screen = screen, tags = ctags})
				end

				awesome.restart()
			end,
			"Restart awesome"),
		awful.key({config.modkey, "Shift"  }, "q", awesome.quit),
		awful.key({config.modkey,          }, ";",
			function ()
				awful.spawn.with_shell("~/.xlock/lock.sh")
			end, "Lock screen"),
		awful.key({config.modkey, "Shift"  }, ":",
			function ()
				awful.spawn.with_shell('~/.config/awesome/locker')
			end,
			"Restart Xautolock"),
		awful.key({config.modkey,          }, "o",
			function ()
				if config.oneko == false then
					awful.spawn("oneko -rv")
				else
					awful.spawn("killall oneko")
				end
				config.oneko = not config.oneko
			end, "Oneko toggle"),
		-- Prompt
		awful.key({config.modkey,          }, "r",
			function ()
				wibars.promptbox[mouse.screen.index]:run()
			end,
			"Prompt for a command"),
		awful.key({config.modkey,          }, "x",
			function ()
				awful.prompt.run(
					{prompt = "Run Lua code: "},
					wibars.promptbox[mouse.screen.index].widget,
					awful.util.eval,
					nil,
					awful.util.getdir("cache") .. "/history_eval"
				)
			end),
		-- Menubar
		awful.key({config.modkey,          }, "p",
			function()
				awful.spawn.with_shell("rofi -show run")
			end),
		-- Other
		awful.key({                        }, "XF86AudioRaiseVolume", APW.Up),
		awful.key({                        }, "XF86AudioLowerVolume", APW.Down),
		awful.key({                        }, "XF86AudioMute",        APW.ToggleMute),
		awful.key({config.modkey           }, "F6", APW.Up),
		awful.key({config.modkey           }, "F5", APW.Down),
		awful.key({config.modkey           }, "F4", APW.ToggleMute),
		awful.key({config.modkey,          }, "F1", keydoc.display)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 0.
for i = 1, 10 do
	bindings.globalkeys	= awful.util.table.join(
		bindings.globalkeys,
		-- View tag only.
		awful.key({config.modkey,          }, "#" .. i + 9,
			function ()
				local screen = mouse.screen
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewonly(tag)
				end
			end),
		-- Toggle tag.
		awful.key({config.modkey, "Control"}, "#" .. i + 9,
			function ()
				local screen = mouse.screen.index
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end),
		-- Move client to tag.
		awful.key({config.modkey, "Shift"  }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen.index)[i]
					if tag then
						awful.client.movetotag(tag)
					end
				end
			end),
		-- Toggle tag.
		awful.key({config.modkey, "Control", "Shift"}, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.toggletag(tag)
					end
				end
			end)
	)
end

-- add the "run or raise" key bindings
bindings.globalkeys		= awful.util.table.join(bindings.globalkeys, ror.genkeys(config.modkey))

bindings.clientkeys		= awful.util.table.join(
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

bindings.clientbuttons	= awful.util.table.join(
	awful.button({                         }, 1,
		function (c)
			client.focus = c
			c:raise()
		end),
	awful.button({config.modkey,           }, 1, awful.mouse.client.move),
	awful.button({config.modkey,           }, 3, awful.mouse.client.resize)
)

return bindings
