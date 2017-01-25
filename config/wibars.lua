local config    = require("config/base")
local menu      = require("config/menu")

local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local vicious   = require("vicious")
local wibox     = require("wibox")

local APW       = require("modules/apw/widget")
local orglendar = require("modules/orglendar")
orglendar.files                   = { -- Specify here all files you want to be parsed, separated by comma.
    events = { config.home .. "/events.org" },
    todo   = { config.home .. "/todo.org" },
}

local awesompd  = require("widgets/awesompd/awesompd")
local ip        = require("widgets/ip")

function wibox.widget.textbox:vicious(args)
    local f = unpack or table.unpack -- Lua 5.1 compat
    vicious.register(self, f(args))
end

local wibars = {}

wibars.taglist_buttons = awful.util.table.join(
    awful.button({             }, 1, function(t) t:view_only() end),
    awful.button({config.modkey}, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({             }, 3, awful.tag.viewtoggle),
    awful.button({config.modkey}, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({             }, 4,
        function(t)
            awful.tag.viewnext(t.screen)
        end),
    awful.button({             }, 5,
        function(t)
            awful.tag.viewprev(t.screen)
        end)
)
-- TODO
wibars.tasklist_buttons = awful.util.table.join(
    awful.button({             }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag.viewonly()
                end
                -- This will also un-minimize
                -- the client, if needed
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
            awful.client.focus.byidx( 1)
        end),
    awful.button({             }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end)
)

wibars.music                               = awesompd:create() -- Create awesompd widget
wibars.music.font                          = config.font
wibars.music.scrolling                     = true -- If true, the text in the widget will be scrolled
wibars.music.output_size                   = 30 -- Set the size of widget in symbols
wibars.music.update_interval               = 10 -- Set the update interval in seconds
wibars.music.path_to_icons                 = config.home .. "/.config/awesome/widgets/awesompd/icons"
-- Set the default music format for Jamendo streams. You can change
-- this option on the fly in awesompd itself.
-- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
wibars.music.jamendo_format                = awesompd.FORMAT_MP3
-- If true, song notifications for Jamendo tracks and local tracks will also contain
-- album cover image.
wibars.music.show_album_cover              = true
-- Specify how big in pixels should an album cover be. Maximum value
-- is 100.
wibars.music.album_cover_size              = 50
-- This option is necessary if you want the album covers to be shown
-- for your local tracks.
wibars.music.mpd_config                    = config.home .. "/.mpd/mpd.conf"
-- Specify the browser you use so awesompd can open links from
-- Jamendo in it.
wibars.music.browser                       = config.browser
-- Specify decorators on the left and the right side of the
-- widget. Or just leave empty strings if you decorate the widget
-- from outside.
wibars.music.ldecorator                    = " "
wibars.music.rdecorator                    = " "
-- Set all the servers to work with (here can be any servers you use)
wibars.music.servers                       = {
    {                               server = "localhost",
    port                                   = 6600 }, }
    -- Set the buttons of the widget
    wibars.music:register_buttons({ { "", awesompd.MOUSE_LEFT, wibars.music:command_playpause() },
    {                               "Control", awesompd.MOUSE_SCROLL_UP, wibars.music:command_prev_track() },
    {                               "Control", awesompd.MOUSE_SCROLL_DOWN, wibars.music:command_next_track() },
    {                               "", awesompd.MOUSE_SCROLL_UP, wibars.music:command_volume_up() },
    {                               "", awesompd.MOUSE_SCROLL_DOWN, wibars.music:command_volume_down() },
    {                               "", awesompd.MOUSE_RIGHT, wibars.music:command_show_menu() },
    --{ "", "XF86AudioLowerVolume", wibars.music:command_volume_down() },
    --{ "", "XF86AudioRaiseVolume", wibars.music:command_volume_up() },
    {                               config.modkey, "Pause", wibars.music:command_playpause() }
})
wibars.music:run()                  -- After all configuration is done, run the widget

wibars.screens = {}

awful.screen.connect_for_each_screen(function(s)
    wibars.screens[s]                 = {}

    -- TODO wallpaper

    local tags                        = require("config/tags")

    -- { Top Wibar
    wibars.screens[s].promptbox       = awful.widget.prompt()
    
    wibars.screens[s].infobar         = {}
    wibars.screens[s].infobar.cyan    = {
        {
            {
                vicious = {vicious.widgets.date, "%b %d %R", 20},
                font    = config.font,
                widget  = wibox.widget.textbox,
                id      = "datewidget"
            },
            left   = 10,
            right  = 10,
            widget = wibox.container.margin
        },
        shape  = gears.shape.hexagon,
        bg     = beautiful.colors.cyan,
        fg     = beautiful.colors.base03,
        widget = wibox.container.background
    }
    wibars.screens[s].infobar.blue    = {
        {
            {
                APW,
                wibars.screens[s].infobar.cyan,
                wibars.cpuicon,
                {
                    -- Battery widget for portable computer
                    vicious = {vicious.widgets.bat, "$1$2", 10, "BAT0"},
                    --vicious    = {vicious.widgets.cpu, "$1%", 5},
                    font    = config.font,
                    widget  = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            left   = 10,
            right  = 10,
            widget = wibox.container.margin
        },
        shape  = gears.shape.hexagon,
        bg     = beautiful.colors.blue,
        fg     = beautiful.colors.base03,
        widget = wibox.container.background
    }
    wibars.screens[s].infobar.violet  = {
        {
            {
                {
                    vicious = {ip, "$1", 15},
                    font    = config.font,
                    widget  = wibox.widget.textbox
                },
                wibars.screens[s].infobar.blue,
                wibars.memicon,
                {
                    vicious = {
                        vicious.widgets.mem,
                        function (widget, args)
                            return args[1] .. "% (" .. math.floor(args[2] / 1024 + .5) .. "/" .. math.floor(args[3] / 1024 + .5) .. " GB)"
                        end,
                        13
                    },
                    font    = config.font,
                    widget  = wibox.widget.textbox
                },
                widget = wibox.layout.fixed.horizontal
            },
            left   = 10,
            right  = 10,
            widget = wibox.container.margin
        },
        shape  = gears.shape.hexagon,
        bg     = beautiful.colors.violet,
        fg     = beautiful.colors.base03,
        widget = wibox.container.background
    }
    wibars.screens[s].infobar.dviolet = {
        {
            {
                {
                    vicious = {vicious.widgets.fs, " ${/home used_gb}/${/home avail_gb} GB", 800},
                    font    = config.font,
                    widget  = wibox.widget.textbox
                },
                wibars.screens[s].infobar.violet,
                {
                    widget = wibox.widget.systray,
                },
                widget = wibox.layout.fixed.horizontal
            },
            left   = 10,
            right  = 10,
            widget = wibox.container.margin
        },
        shape  = gears.shape.hexagon,
        bg     = beautiful.colors.dviolet,
        fg     = beautiful.colors.base03,
        widget = wibox.container.background
    }
    wibars.screens[s].infobar         = {
        wibars.screens[s].infobar.dviolet,
        layout = wibox.layout.fixed.horizontal
    }
    
    awful.widget.layoutbox(s):buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))
    
    wibars.screens[s].wibar_top       = awful.wibar({ position = "top", screen = s, bg = "#002b3600" })
    wibars.screens[s].wibar_top : setup {
        {
            {
                menu.launcher,
                awful.widget.taglist(
                    s,
                    awful.widget.taglist.filter.noempty,
                    wibars.taglist_buttons
                ),
                wibars.screens[s].promptbox,
                layout = wibox.layout.fixed.horizontal
            },
            nil,
            nil,
            layout = wibox.layout.align.horizontal
        },
        {
            nil,
            wibars.screens[s].infobar,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        {
            nil,
            nil,
            {
                wibars.music.widget,
                awful.widget.layoutbox(s),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        },
        id     = "topbar",
        layout = wibox.layout.ratio.horizontal,
    }
    wibars.screens[s].wibar_top.topbar:inc_ratio(2, 0.3)
    --calendar.addCalendarToWidget(wibars.screens[s].wibar_top:get_children_by_id("datewidget")[1])
    
    orglendar.register(wibars.screens[s].wibar_top:get_children_by_id("datewidget")[1])
    -- }
    
    -- { Bottom Wibar
    
        wibars.screens[s].wibar_bot   = awful.wibar({ position = "bottom", screen = s, bg = "#002b3600" })
        wibars.screens[s].wibar_bot : setup {
            nil,
            awful.widget.tasklist(
                s,
                awful.widget.tasklist.filter.currenttags,
                wibars.tasklist_buttons,
                { bg_normal = "#002b3600", bg_focus = "#002b3600" }
            ),
            nil,
            layout = wibox.layout.align.horizontal
        }
    
    -- }
end)

return wibars
