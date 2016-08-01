local gears = require("gears")
local config = require("config/base")

local wp = {}

-- configuration
wp.timeout = 600
wp.freeze = false
wp.path = config.wallpaperfolder

wp.files = {}
for f in io.popen("ls "..wp.path):lines() do
	table.insert(wp.files, f)
end
wp.index = math.random( 1, #wp.files)

-- setup the timer
wp.timer = timer { timeout = 0 }
wp.timer:connect_signal("timeout", function()

	-- set wallpaper to current index
	for r = 1, screen.count() do
		gears.wallpaper.maximized( wp.path .. wp.files[wp.index] , r, true)
	end

	-- stop the timer (we don't need multiple instances running at the same time)
	wp.timer:stop()

	-- get next random index
	wp.index = math.random( 1, #wp.files)

	--restart the timer
	wp.timer.timeout = wp.timeout
	wp.timer:start()
end)

return wp
