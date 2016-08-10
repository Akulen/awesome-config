-- {{{ Grab environment
local tonumber = tonumber
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
local math = {
    min = math.min,
    floor = math.floor
}
-- }}}


local ip = {}


-- {{{ IP widget type
local function worker(format, warg)
	local f = assert(io.popen("ip addr show enp9s0", 'r'))
	local s = assert(f:read('*a'))
	f:close()
	local ipadd = string.match(s, "inet ([^/]*)/")
    return {ipadd}
end
-- }}}

return setmetatable(ip, { __call = function(_, ...) return worker(...) end })
