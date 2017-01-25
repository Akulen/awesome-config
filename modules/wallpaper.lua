local awful		= require("awful")
local gears		= require("gears")

math.randomseed(os.time())

local wp  = {}
wp.config = require("config/wallpaper")

wp.files  = {}
wp.index  = {}
wp.timer  = {}

wp.reload = function()
    for f in io.popen("ls " .. wp.config.path):lines() do
    	table.insert(wp.files, f)
    end
end
wp.change = function(s)
    wp.index[s]     = math.random( 1, #wp.files)
    local wallpaper = wp.config.path .. wp.files[wp.index[s]]
    gears.wallpaper.maximized(wallpaper, s, true)
end

wp.reload()

awful.screen.connect_for_each_screen(function(s)
    -- setup the timer
    wp.timer[s] = gears.timer { timeout = 0 }
    wp.timer[s]:connect_signal("timeout", function()
    
    	-- set wallpaper to current index
        wp.change(s)
    
    	-- stop the timer (we don't need multiple instances running at the same time)
    	wp.timer[s]:stop()
    
    	--restart the timer
    	wp.timer[s].timeout = wp.config.timeout
    	wp.timer[s]:start()
    end)
    wp.timer[s]:emit_signal("timeout")
end)

-- Change GRUB background at boot

local grub_bg = math.random(1, #wp.files)
awful.spawn.with_shell("convert " .. wp.config.path .. wp.files[grub_bg] .. " /boot/grub/themes/SteamBP/background.png")

return wp
