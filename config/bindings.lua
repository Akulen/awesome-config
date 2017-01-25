local config        = require("config/base")
local wp            = require("modules/wallpaper")

local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local revelation    = require("revelation")

local APW           = require("modules/apw/widget")
local menu          = require("config/menu")
local ror           = require("modules/aweror")
local tags          = require("config/tags")
local utils         = require("modules/utils")
local wibars        = require("config/wibars")

local bindings      = {client = require("config/clientbindings")}

-- Mouse bindings
bindings.mouse = awful.util.table.join(
    awful.button({ }, 3, function () menu.menu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

-- Key bindings
bindings.globalkeys = awful.util.table.join(
-- TODO
    --awful.key({config.modkey, "Control"}, "t",
    --    function()
    --        local s = awful.screen.focused()
    --        --local curTag = s.selected_tag.index
    --        for t = 1, 10 do
    --            tags.tags[s.index][tags.current][t].activated = false
    --            tags.tags[s.index][3 - tags.current][t].activated = true
    --        end
    --        tags.current = 3 - tags.current
    --        --tags.tags[s.index][tags.current][curTag].selected = true
    --        tags.tags[s.index][tags.current][1].selected = true
    --    end,
    --    "Switch tag bars"),
    awful.key({config.modkey,          }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "Tag management"}),
    awful.key({config.modkey,          }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "Tag management"}),
    awful.key({config.modkey,          }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "Tag management"}),
    awful.key({config.modkey,          }, "e",
        function()
            revelation({rule = {class = config.Terminal}})
        end,
        {description = "revelation for terminals", group = "Tag management"}),
    awful.key({config.modkey,          }, "b",
        function()
            wp.timer[awful.screen.focused()]:emit_signal("timeout")
        end,
        {description = "swap wallpaper of focused screen", group = "Misc"}),
    awful.key({config.modkey, "Shift"  }, "b",
        function ()
            local s = awful.screen.focused()
            if wp.config.freeze[s] == false then
                wp.timer[s]:stop()
            else
                wp.timer[s]:start()
            end
            wp.config.freeze[s] = not wp.config.freeze[s]
        end,
        {description = "freeze wallpaper swapper of focused screen", group = "Misc"}),
    awful.key({config.modkey, "Control"}, "b", wp.reload,
        {description = "reload wallpapers", group = "Misc"}),

    awful.key({config.modkey,          }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next window by index", group = "Focus"}),
    awful.key({config.modkey,          }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous window by index", group = "Focus"}),
    awful.key({config.modkey, "Control"}, "j",
        function ()
            awful.screen.focus_relative( 1)
        end,
        {description = "focus next screen", group = "Focus"}),
    awful.key({config.modkey, "Control"}, "k",
        function ()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus previous screen", group = "Focus"}),
    awful.key({config.modkey,          }, "w",
        function ()
            menu.menu:show()
        end,
        {description = "show main menu", group = "Focus"}),
    awful.key({config.modkey,          }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "Focus"}),
    awful.key({config.modkey,          }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus previously focused window", group = "Focus"}),

-- Layout manipulation
    awful.key({config.modkey,          }, "l",
        function ()
            awful.tag.incmwfact( 0.05)
        end,
        {description = "increase master width factor", group = "Layout manipulation"}),
    awful.key({config.modkey,          }, "h",
        function ()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master-width factor", group = "Layout manipulation"}),
    awful.key({config.modkey, "Shift"  }, "h",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase number of masters", group = "Layout manipulation"}),
    awful.key({config.modkey, "Shift"  }, "l",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease number of masters", group = "Layout manipulation"}),
    awful.key({config.modkey, "Control"}, "h",
        function ()
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase number of columns", group = "Layout manipulation"}),
    awful.key({config.modkey, "Control"}, "l",
        function ()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease number of columns", group = "Layout manipulation"}),
    awful.key({config.modkey,          }, "space",
        function ()
            awful.layout.inc( 1)
        end,
        {description = "select next layout", group = "Layout manipulation"}),
    awful.key({config.modkey, "Shift"  }, "space",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous layout", group = "Layout manipulation"}),
    awful.key({config.modkey, "Shift"  }, "j",
        function ()
            awful.client.swap.byidx( 1)
        end,
        {description = "swap with next window by index", group = "Layout manipulation"}),
    awful.key({config.modkey, "Shift"  }, "k",
        function ()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous window by index", group = "Layout manipulation"}),
    awful.key({}, "XF86MonBrightnessDown",
        function ()
            awful.spawn("xbacklight -dec 10")
        end),
    awful.key({}, "XF86MonBrightnessUp",
        function ()
            awful.spawn("xbacklight -inc 10")
        end),

    awful.key({config.modkey, "Control"}, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}),

-- Standard program
    awful.key({config.modkey,          }, "Return",
        function ()
            awful.spawn(config.terminal)
        end),
    awful.key({config.modkey,          }, "t",
        function ()
            awful.spawn(config.terminal)
        end,
        {description = "spawn a terminal", group = "Misc"}),
    awful.key({}, "Print",
        function ()
            awful.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'")
        end),
    awful.key({config.modkey, "Control"}, "r", awesome.restart,
        {description = "restart awesome", group = "Misc"}),
    awful.key({config.modkey, "Shift"  }, "q", awesome.quit,
        {description = "quit awesome", group = "Misc"}),
    awful.key({config.modkey,          }, ";",
        function ()
            awful.spawn.with_shell("~/.xlock/lock.sh")
        end,
        {description = "lock screen", group = "Misc"}),
    awful.key({config.modkey,          }, "o",
        function ()
            if config.oneko == false then
                awful.spawn("oneko -rv")
            else
                awful.spawn("killall oneko")
            end
            config.oneko = not config.oneko
        end,
        {description = "toggle oneko", group = "Misc"}),
    ---- Prompt
    --awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --          {description = "run prompt", group = "launcher"}),

    --awful.key({ modkey }, "x",
    --          function ()
    --              awful.prompt.run {
    --                prompt       = "Run Lua code: ",
    --                textbox      = awful.screen.focused().mypromptbox.widget,
    --                exe_callback = awful.util.eval,
    --                history_path = awful.util.get_cache_dir() .. "/history_eval"
    --              }
    --          end,
    --          {description = "lua execute prompt", group = "awesome"}),
    -- Prompt
    awful.key({config.modkey,          }, "r",
        function ()
            wibars.screens[awful.screen.focused()].promptbox:run()
        end,
        {description = "prompt for a command", group = "Misc"}),
    awful.key({config.modkey,          }, "x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = wibars.screens[awful.screen.focused()].promptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "Misc"}),
    -- Menubar
    awful.key({config.modkey,          }, "p",
        function()
            awful.spawn.with_shell("rofi -show run")
        end,
        {description = "show rofi", group = "Misc"}),
    -- Other
    awful.key({                        }, "XF86AudioRaiseVolume", APW.Up),
    awful.key({                        }, "XF86AudioLowerVolume", APW.Down),
    awful.key({                        }, "XF86AudioMute",        APW.ToggleMute),
    awful.key({config.modkey           }, "F6", APW.Up),
    awful.key({config.modkey           }, "F5", APW.Down),
    awful.key({config.modkey           }, "F4", APW.ToggleMute),
    awful.key({config.modkey,          }, "F1", hotkeys_popup.show_help)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 0.
for i = 1, 10 do
    bindings.globalkeys    = awful.util.table.join(
        bindings.globalkeys,
        -- View tag only.
        awful.key({config.modkey,          }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. (i % 10), group = "Tag"}),
        -- Toggle tag.
        awful.key({config.modkey, "Control"}, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. (i % 10), group = "Tag"}),
        -- Move client to tag.
        awful.key({config.modkey, "Shift"  }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. (i % 10), group = "Tag"}),
        -- Toggle tag.
        awful.key({config.modkey, "Control", "Shift"}, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. (i % 10), group = "Tag"})
    )
end

-- add the "run or raise" key bindings
bindings.globalkeys = awful.util.table.join(bindings.globalkeys, ror.genkeys(config.modkey))

return bindings
