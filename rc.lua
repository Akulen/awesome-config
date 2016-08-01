-- Load config
local config = require("config/base")

-- {{{ Standard awesome library
-- Gear
	local gears = require("gears")
-- Awful
	local awful = require("awful")
	awful.rules = require("awful.rules")
	require("awful.autofocus")
-- Widget and layout library
	local wibox = require("wibox")
-- Theme handling library
	local beautiful = require("beautiful")
	-- Themes define colours, icons, font and wallpapers.
	beautiful.init(config.themepath)
-- Notification library
	local naughty = require("naughty")
-- Vicious
	local vicious = require("vicious")
-- Lain
	local lain = require("lain")
-- }}}

-- {{{ Local Modules
-- Key Documentation
	require("modules/keydoc")
-- Run or Raise
	local ror = require("modules/aweror")
-- Sound library
	local APW = require("modules/apw/widget")
-- Revelation
	require("modules/revelation")
-- Wallpaper
	local wp = require("modules/wallpaper")
-- }}}

-- Check errors
require("errors")

-- {{{ Wallpaper
	if beautiful.wallpaper then
	    for s = 1, screen.count() do
	        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	    end
	end

	-- initial start when rc.lua is first run
	wp.timer:start()
-- }}}

-- Tags
local tags = require("modules/tags") 

-- Menu
local menu = require("modules/menu")

-- {{{ Wibox

--{{-- Time and Date Widget }} --
tdwidget = wibox.widget.textbox()
local strf = '<span font="' .. config.font .. '" color="#EEEEEE" background="#777E76">%b %d %I:%M</span>'
vicious.register(tdwidget, vicious.widgets.date, strf, 20)

clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.clock)

--{{ Net Widget }} --
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, function(widget, args)
    local interface = ""
    if args["{wlp2s0 carrier}"] == 1 then
        interface = "wlp2s0"
    elseif args["{enp0s25 carrier}"] == 1 then
        interface = "enp0s25"
    else
        return ""
    end
    return '<span background="#C2C2A4" font="' .. config.font .. '"> <span font ="' .. config.font .. '" color="#FFFFFF">' .. args["{" .. interface .. " down_kb}"] .. 'kbps' .. '</span></span>' end, 10)

---{{---| Wifi Signal Widget |-------
neticon = wibox.widget.imagebox()
vicious.register(neticon, vicious.widgets.wifi, function(widget, args)
    local sigstrength = tonumber(args["{link}"])
    if sigstrength > 69 then
        neticon:set_image(beautiful.nethigh)
    elseif sigstrength > 40 and sigstrength < 70 then
        neticon:set_image(beautiful.netmedium)
    else
        neticon:set_image(beautiful.netlow)
    end
end, 120, 'wlp3s0')


--{{ Battery Widget }} --
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.baticon)

batwidget = wibox.widget.textbox()
vicious.register( batwidget, vicious.widgets.bat, '<span background="#92B0A0" font="' .. config.font .. '"><span font="' .. config.font .. '" color="#FFFFFF" background="#92B0A0">$1$2% </span></span>', 30, "BAT0" )
--{{---| File Size widget |-----
fswidget = wibox.widget.textbox()

vicious.register(fswidget,
	vicious.widgets.fs,
	'<span background="'..beautiful.colors.dviolet..'" font="' .. config.font .. '" color="#EEEEEE">  ${/home used_gb}/${/home avail_gb} GB </span>',
	800)

----{{--| Volume / volume icon |----------
volume = wibox.widget.textbox()
vicious.register(volume, vicious.widgets.volume,
'<span background="#4B3B51" font="' .. config.font .. '"><span font="' .. config.font .. '" color="#EEEEEE"> Vol:$1 </span></span>', 0.3, "Master")

volumeicon = wibox.widget.imagebox()
vicious.register(volumeicon, vicious.widgets.volume, function(widget, args)
    local paraone = tonumber(args[1])

    if args[2] == "♩" or paraone == 0 then
        volumeicon:set_image(beautiful.mute)
    elseif paraone >= 67 and paraone <= 100 then
        volumeicon:set_image(beautiful.volhi)
    elseif paraone >= 33 and paraone <= 66 then
        volumeicon:set_image(beautiful.volmed)
    else
        volumeicon:set_image(beautiful.vollow)
    end

end, 0.3, "Master")

--{{---| CPU / sensors widget |-----------
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu,
'<span background="'..beautiful.colors.violet..'" font="' .. config.font .. '"> <span font="' .. config.font .. '" color="'..beautiful.colors.base03..'">$1%</span></span>', 5)

cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.cpuicon)

--{{--| MEM widget |-----------------
memwidget = wibox.widget.textbox()

vicious.register(memwidget, vicious.widgets.mem, '<span background="#777E76" font="' .. config.font .. '"> <span font="' .. config.font .. '" color="#EEEEEE" background="#777E76">$1% $2MB </span></span>', 20)
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.mem)

--{{--| Mail widget |---------
-- mailicon = wibox.widget.imagebox()
-- 
-- vicious.register(mailicon, vicious.widgets.gmail, function(widget, args)
--     local newMail = tonumber(args["{count}"])
--     if newMail > 0 then
--         mailicon:set_image(beautiful.mail)
--     else
--         mailicon:set_image(beautiful.mailopen)
--     end
-- end, 15)

-- to make GMail pop up when pressed:
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1,
-- function () awful.util.spawn_with_shell(browser .. " gmail.com") end)))


-- Create a wibox for each screen and add it
mywiboxtop = {}
mywiboxbot = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ config.modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ config.modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

datewidget = wibox.widget.textbox()
vicious.register(datewidget,
				 vicious.widgets.date,
				 "<span font='" .. config.font .. "' color='"..beautiful.colors.base03.."' background='"..beautiful.colors.cyan.."'>%b %d %R</span>",
				 20)

memwidget2 = wibox.widget.textbox()
vicious.register(memwidget2, vicious.widgets.mem, "<span background='"..beautiful.colors.violet.."' font='" .. config.font .. "' color='"..beautiful.colors.base03.."'>$1% ($2MB/$3MB)</span>", 13)

batterywidget = wibox.widget.textbox()
vicious.register(batterywidget, vicious.widgets.bat, "<span background='"..beautiful.colors.blue.."' font='" .. config.font .. "' color='"..beautiful.colors.base03.."'>$1$2%</span>", 10, "BAT0")

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(tags.layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(tags.layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(tags.layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(tags.layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywiboxtop[s] = awful.wibox({ position = "top", screen = s, height = "19" })
    mywiboxbot[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(menu.launcher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

	-- Informative widgets
-- {{ These are the power arrow dividers/separators }} --
arr1 = wibox.widget.imagebox()
arr1:set_image(beautiful.arr1)
rra1 = wibox.widget.imagebox()
rra1:set_image(beautiful.rra1)
arr2 = wibox.widget.imagebox()
arr2:set_image(beautiful.arr2)
rra2 = wibox.widget.imagebox()
rra2:set_image(beautiful.rra2)
arr3 = wibox.widget.imagebox()
arr3:set_image(beautiful.arr3)
rra3 = wibox.widget.imagebox()
rra3:set_image(beautiful.rra3)
arr4 = wibox.widget.imagebox()
arr4:set_image(beautiful.arr4)
rra4 = wibox.widget.imagebox()
rra4:set_image(beautiful.rra4)
arr5 = wibox.widget.imagebox()
arr5:set_image(beautiful.arr5)
arr6 = wibox.widget.imagebox()
arr6:set_image(beautiful.arr6)
arr7 = wibox.widget.imagebox()
arr7:set_image(beautiful.arr7)
arr8 = wibox.widget.imagebox()
arr8:set_image(beautiful.arr8)
arr9 = wibox.widget.imagebox()
arr9:set_image(beautiful.arr9)

	local info = wibox.layout.fixed.horizontal()
	info:add(arr4)
	info:add(fswidget)
	info:add(arr3)
	info:add(cpuwidget)
	info:add(cpuicon)
	info:add(arr2)
	info:add(APW)
	info:add(arr1)
	info:add(datewidget)
	info:add(rra1)
	info:add(baticon)
    info:add(batterywidget)
	info:add(rra2)
	info:add(memicon)
	info:add(memwidget2)
	info:add(rra3)
    if s == 1 then info:add(wibox.widget.systray()) end
	info:add(rra4)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
	-- right_layout:add(mailicon)
	right_layout:add(neticon)
	right_layout:add(netwidget)
    right_layout:add(mylayoutbox[s])
	
    -- Now bring it all together (with the tasklist in the middle)
    local layouttop = wibox.layout.align.horizontal()
    layouttop:set_left(left_layout)
    layouttop:set_middle(info)
    layouttop:set_right(right_layout)

    local layoutbot = wibox.layout.align.horizontal()
    layoutbot:set_middle(mytasklist[s])

    mywiboxtop[s]:set_widget(layouttop)
    mywiboxbot[s]:set_widget(layoutbot)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () menu.menu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	keydoc.group("Tag management"),
    awful.key({ config.modkey,           }, "Left",   awful.tag.viewprev       , "Next tag"),
    awful.key({ config.modkey,           }, "Right",  awful.tag.viewnext       , "Previous tag"),
    awful.key({ config.modkey,           }, "Escape", awful.tag.history.restore, "Switch to previous tag"),
    awful.key({ config.modkey,           }, "e", function() revelation({class="URxvt"}) end),
    awful.key({ config.modkey,           }, "b", function() wp.timer:emit_signal("timeout") end, "Change background"),
	awful.key({ config.modkey, "Shift"   }, "b",
		function ()
			if wp.freeze == false then
				wp.timer:stop()
			else
				wp.timer:start()
			end
			wp.freeze = not wp.freeze
		end, "Freeze Wallpaper swapper"),

	keydoc.group("Focus"),
    awful.key({ config.modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end, "Focus next window"),
    awful.key({ config.modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
		end, "Focus previous window"),
    awful.key({ config.modkey,           }, "w", function () menu.menu:show() end),

    -- Layout manipulation
	keydoc.group("Layout manipulation"),
    awful.key({ config.modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end, "Increase master-width factor"),
    awful.key({ config.modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end, "Decrease master-width factor"),
    awful.key({ config.modkey, "Shift"   }, "l",     function () awful.tag.incnmaster( 1)      end, "Increase number of masters"),
    awful.key({ config.modkey, "Shift"   }, "h",     function () awful.tag.incnmaster(-1)      end, "Decrease number of masters"),
    awful.key({ config.modkey, "Control" }, "l",     function () awful.tag.incncol( 1)         end, "Increase number of columns"),
    awful.key({ config.modkey, "Control" }, "h",     function () awful.tag.incncol(-1)         end, "Decrease number of columns"),
    awful.key({ config.modkey,           }, "space", function () awful.layout.inc(tags.layouts,  1) end, "Next layout"),
    awful.key({ config.modkey, "Shift"   }, "space", function () awful.layout.inc(tags.layouts, -1) end, "Previous layout"),
    awful.key({ config.modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, "Swap with next window"),
    awful.key({ config.modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, "Swap with previous window"),
    awful.key({ config.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ config.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ config.modkey,           }, "u", awful.client.urgent.jumpto),
	awful.key({ }, "XF86MonBrightnessDown", function ()
		awful.util.spawn("xbacklight -dec 10") end),
	awful.key({ }, "XF86MonBrightnessUp", function ()
    	awful.util.spawn("xbacklight -inc 10") end),
    awful.key({ config.modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, "Focus previously focused window"),

    awful.key({ config.modkey, "Control" }, "n", awful.client.restore),

    -- Standard program
	keydoc.group("Misc"),
    awful.key({ config.modkey,           }, "Return", function () awful.util.spawn(config.terminal) end, "Spawn a terminal"),
    awful.key({ config.modkey,           }, "t", function () awful.util.spawn(config.terminal) end, "Spawn a terminal"),
	awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end, "Screenshot"),
    awful.key({ config.modkey, "Control" }, "r", awesome.restart, "Restart awesome"),
    awful.key({ config.modkey, "Shift"   }, "q", awesome.quit),
	awful.key({ config.modkey }, ";",
		function ()
			awful.util.spawn_with_shell("~/.xlock/lock.sh")
		end, "Lock screen"),
    awful.key({ config.modkey, "Shift"   }, ":", function () awful.util.spawn_with_shell('~/.config/awesome/locker') end, "Restart Xautolock"),
	awful.key({ config.modkey,                     }, "o",
		function ()
			if config.oneko == false then
				awful.util.spawn("oneko -rv")
			else
				awful.util.spawn("killall oneko")
			end
			config.oneko = not config.oneko
		end, "Oneko toggle"),

    -- Prompt
    awful.key({ config.modkey },            "r",     function () mypromptbox[mouse.screen]:run() end, "Prompt for a command"),

    awful.key({ config.modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ config.modkey }, "p", function() awful.util.spawn_with_shell("rofi -show run") end),

	-- Other
	awful.key({ }, "XF86AudioRaiseVolume",  APW.Up),
	awful.key({ }, "XF86AudioLowerVolume",  APW.Down),
	awful.key({ }, "XF86AudioMute",         APW.ToggleMute),
	awful.key({ config.modkey, }, "F1", keydoc.display)
)

-- add the "run or raise" key bindings
globalkeys = awful.util.table.join(globalkeys, ror.genkeys(config.modkey))

clientkeys = awful.util.table.join(
	keydoc.group("Window-specific bindings"),
    awful.key({ config.modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, "Fullscreen"),
    awful.key({ config.modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ config.modkey, "Control" }, "space",  awful.client.floating.toggle                     , "Toggle floating"),
    awful.key({ config.modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, "Switch with master window"),
    awful.key({ config.modkey,           }, "o",      awful.client.movetoscreen                        , "Move to the other screen"),
    awful.key({ config.modkey, "Shift"	  }, "t",      function (c) c.ontop = not c.ontop            end, "Raise window"),
    awful.key({ config.modkey,           }, "n",
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

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ config.modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ config.modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ config.modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ config.modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ config.modkey }, 1, awful.mouse.client.move),
    awful.button({ config.modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
					 size_hints_honor = false,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Vivaldi to always map on tags number 2 of screen 1.
    { rule = { class = config.browser },
      properties = { tag = tags.tags[1][1] } },
    { rule = { class = "Skype" },
      properties = { tag = tags.tags[1][2] } },
    { rule = { class = "Skype" , name = "rigauto - Skype™" },
      properties = { floating = true } },
    { rule = { class = "discord" },
      properties = { tag = tags.tags[1][2] } },
    { rule = { class = "Clementine" },
      properties = { tag = tags.tags[1][9] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

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
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
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

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

APWTimer = timer({ timeout = 0.5 }) -- set update interval in s
APWTimer:connect_signal("timeout", APW.Update)
APWTimer:start()

-- Change GRUB background at boot

grub_bg = math.random(1, #wp.files)
awful.util.spawn_with_shell("convert "..wp.path..wp.files[grub_bg].." /boot/grub/themes/SteamBP/background.png")

-- Startup commands

awful.util.spawn_with_shell("setxkbmap -option compose:ralt")
awful.util.spawn_with_shell("xcompmgr -C -f -D 3")
