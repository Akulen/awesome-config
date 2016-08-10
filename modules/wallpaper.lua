local awful		= require("awful")
local gears		= require("gears")

local wp	= {}
wp.config	= require("config/wallpaper")

wp.files = {}
for f in io.popen("ls " .. wp.config.path):lines() do
	table.insert(wp.files, f)
end
math.randomseed(os.time())
wp.index = math.random( 1, #wp.files)

-- setup the timer
wp.timer = gears.timer { timeout = 0 }
wp.timer:connect_signal("timeout", function()

	-- set wallpaper to current index
	for r = 1, screen.count() do
		gears.wallpaper.maximized( wp.config.path .. wp.files[wp.index] , r, true)
	end

	-- stop the timer (we don't need multiple instances running at the same time)
	wp.timer:stop()

	-- get next random index
	wp.index = math.random( 1, #wp.files)

	--restart the timer
	wp.timer.timeout = wp.config.timeout
	wp.timer:start()
end)

-- Change GRUB background at boot

grub_bg = math.random(1, #wp.files)
awful.spawn.with_shell("convert " .. wp.config.path .. wp.files[grub_bg] .. " /boot/grub/themes/SteamBP/background.png")

return wp
