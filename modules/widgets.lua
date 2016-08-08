local beautiful	= require("beautiful")
local vicious	= require("vicious")
local wibox		= require("wibox")

local config	= require("config/base")

local widgets = {}

-- {{{ Wibox

--{{-- Time and Date Widget }} --
widgets.tdwidget = wibox.widget.textbox()
local strf = '<span font="' .. config.font .. '" color="#EEEEEE" background="#777E76">%b %d %I:%M</span>'
vicious.register(widgets.tdwidget, vicious.widgets.date, strf, 20)

widgets.clockicon = wibox.widget.imagebox()
widgets.clockicon:set_image(beautiful.clock)

--{{ Net Widget }} --
widgets.netwidget = wibox.widget.textbox()
vicious.register(widgets.netwidget, vicious.widgets.net, function(widget, args)
    local interface = ""
    if args["{wlp2s0 carrier}"] == 1 then
        interface = "wlp2s0"
    elseif args["{enp9s0 carrier}"] == 1 then
        interface = "enp9s0"
    else
        return ""
    end
    return '<span background="#C2C2A4" font="' .. config.font .. '"> <span font ="' .. config.font .. '" color="#FFFFFF">' .. args["{" .. interface .. " down_kb}"] .. 'kbps' .. '</span></span>' end, 10)

---{{---| Wifi Signal Widget |-------
-- widgets.neticon = wibox.widget.imagebox()
-- vicious.register(widgets.neticon, vicious.widgets.wifi, function(widget, args)
--     local sigstrength = tonumber(args["{link}"])
--     if sigstrength > 69 then
--         neticon:set_image(beautiful.nethigh)
--     elseif sigstrength > 40 and sigstrength < 70 then
--         neticon:set_image(beautiful.netmedium)
--     else
--         neticon:set_image(beautiful.netlow)
--     end
-- end, 120, 'wlp3s0')


--{{ Battery Widget }} --
widgets.baticon = wibox.widget.imagebox()
widgets.baticon:set_image(beautiful.baticon)

widgets.batwidget = wibox.widget.textbox()
vicious.register(widgets.batwidget, vicious.widgets.bat, '<span background="#92B0A0" font="' .. config.font .. '"><span font="' .. config.font .. '" color="#FFFFFF" background="#92B0A0">$1$2% </span></span>', 30, "BAT0" )
--{{---| File Size widget |-----
widgets.fswidget = wibox.widget.textbox()

vicious.register(widgets.fswidget,
	vicious.widgets.fs,
	'<span background="' .. beautiful.colors.dviolet .. '" font="' .. config.font .. '" color="#EEEEEE">  ${/home used_gb}/${/home avail_gb} GB </span>',
	800)

----{{--| Volume / volume icon |----------
widgets.volume = wibox.widget.textbox()
vicious.register(widgets.volume, vicious.widgets.volume,
'<span background="#4B3B51" font="' .. config.font .. '"><span font="' .. config.font .. '" color="#EEEEEE"> Vol:$1 </span></span>', 0.3, "Master")

widgets.volumeicon = wibox.widget.imagebox()
vicious.register(widgets.volumeicon, vicious.widgets.volume, function(widget, args)
    local paraone = tonumber(args[1])

    if args[2] == "♩" or paraone == 0 then
        widgets.volumeicon:set_image(beautiful.mute)
    elseif paraone >= 67 and paraone <= 100 then
        widgets.volumeicon:set_image(beautiful.volhi)
    elseif paraone >= 33 and paraone <= 66 then
        widgets.volumeicon:set_image(beautiful.volmed)
    else
        widgets.volumeicon:set_image(beautiful.vollow)
    end

end, 0.3, "Master")

--{{---| CPU / sensors widget |-----------
widgets.cpuwidget = wibox.widget.textbox()
vicious.register(widgets.cpuwidget, vicious.widgets.cpu,
'<span background="' .. beautiful.colors.violet .. '" font="' .. config.font .. '"> <span font="' .. config.font .. '" color="' .. beautiful.colors.base03 .. '">$1%</span></span>', 5)

widgets.cpuicon = wibox.widget.imagebox()
widgets.cpuicon:set_image(beautiful.cpuicon)

--{{--| MEM widget |-----------------
widgets.memwidget = wibox.widget.textbox()

vicious.register(widgets.memwidget, vicious.widgets.mem, '<span background="#777E76" font="' .. config.font .. '"> <span font="' .. config.font .. '" color="#EEEEEE" background="#777E76">$1% $2MB </span></span>', 20)
widgets.memicon = wibox.widget.imagebox()
widgets.memicon:set_image(beautiful.mem)

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

widgets.datewidget = wibox.widget.textbox()
vicious.register(widgets.datewidget,
				 vicious.widgets.date,
				 "<span font='" .. config.font .. "' color='"..beautiful.colors.base03.."' background='"..beautiful.colors.cyan.."'>%b %d %R</span>",
				 20)

widgets.memwidget2 = wibox.widget.textbox()
vicious.register(widgets.memwidget2, vicious.widgets.mem, "<span background='"..beautiful.colors.violet.."' font='" .. config.font .. "' color='"..beautiful.colors.base03.."'>$1% ($2MB/$3MB)</span>", 13)

widgets.batterywidget = wibox.widget.textbox()
vicious.register(widgets.batterywidget, vicious.widgets.bat, "<span background='"..beautiful.colors.blue.."' font='" .. config.font .. "' color='"..beautiful.colors.base03.."'>$1$2%</span>", 10, "BAT0")


return widgets
