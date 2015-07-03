---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- Perso
theme.colors = {}
theme.colors.base3   = "#002b36"
theme.colors.base2   = "#073642"
theme.colors.base1   = "#586e75"
theme.colors.base0   = "#657b83"
theme.colors.base00  = "#839496"
theme.colors.base01  = "#93a1a1"
theme.colors.base02  = "#eee8d5" 
theme.colors.base03  = "#fdf6e3"
theme.colors.yellow  = "#b58900" 
theme.colors.orange  = "#cb4b16"  
theme.colors.red     = "#dc322f"   
theme.colors.magenta = "#d33682"    
theme.colors.violet  = "#6c71c4"
theme.colors.blue    = "#268bd2"
theme.colors.cyan    = "#2aa198"
theme.colors.green   = "#859900"
theme.colors.dviolet = "#4B3B51"
--

pathToConfig = "~/.config/awesome/"
theme.default_themes_path = "/usr/share/awesome/themes"

theme.font          = "Terminus 9"

theme.bg_normal     = theme.colors.base3
theme.bg_focus      = theme.colors.base1
theme.bg_urgent     = theme.colors.red
theme.bg_systray    = theme.colors.dviolet

theme.fg_normal     = theme.colors.base02
theme.fg_focus      = theme.colors.base03
theme.fg_urgent     = theme.colors.base3

theme.border_width  = "2"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent

theme.titlebar_bg_focus		= theme.bg_focus
theme.titlebar_bg_normal	= theme.bg_normal

theme.mouse_finder_color = theme.colors.green
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.default_themes_path.."/zenburn/taglist/squarefz.png" 
theme.taglist_squares_unsel = theme.default_themes_path.."/zenburn/taglist/squarez.png" 

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.awesome_icon		= theme.default_themes_path.."/zenburn/awesome-icon.png"
theme.menu_submenu_icon	= theme.default_themes_path.."/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_focus  = theme.default_themes_path.."/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.default_themes_path.."/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme.default_themes_path.."/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.default_themes_path.."/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_themes_path.."/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_themes_path.."/zenburn/titlebar/maximized_normal_inactive.png"


-- theme.wallpaper = pathToConfig .. "powerarrowf/candy_bean_wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_tile       = theme.default_themes_path.."/zenburn/layouts/tile.png"
theme.layout_tileleft   = theme.default_themes_path.."/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = theme.default_themes_path.."/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = theme.default_themes_path.."/zenburn/layouts/tiletop.png"
theme.layout_fairv      = theme.default_themes_path.."/zenburn/layouts/fairv.png"
theme.layout_fairh      = theme.default_themes_path.."/zenburn/layouts/fairh.png"
theme.layout_spiral     = theme.default_themes_path.."/zenburn/layouts/spiral.png"
theme.layout_dwindle    = theme.default_themes_path.."/zenburn/layouts/dwindle.png"
theme.layout_max        = theme.default_themes_path.."/zenburn/layouts/max.png"
theme.layout_fullscreen = theme.default_themes_path.."/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = theme.default_themes_path.."/zenburn/layouts/magnifier.png"
theme.layout_floating   = theme.default_themes_path.."/zenburn/layouts/floating.png"


--{{ For the Dark Theme }} --

theme.arr1 = pathToConfig .. "powerarrowf/icons/arr1.png"
theme.rra1 = pathToConfig .. "powerarrowf/icons/rra1.png"
theme.arr2 = pathToConfig .. "powerarrowf/icons/arr2.png"
theme.rra2 = pathToConfig .. "powerarrowf/icons/rra2.png"
theme.arr3 = pathToConfig .. "powerarrowf/icons/arr3.png"
theme.rra3 = pathToConfig .. "powerarrowf/icons/rra3.png"
theme.arr4 = pathToConfig .. "powerarrowf/icons/arr4.png"
theme.rra4 = pathToConfig .. "powerarrowf/icons/rra4.png"
theme.arr5 = pathToConfig .. "powerarrowf/icons/arr5.png"
theme.arr6 = pathToConfig .. "powerarrowf/icons/arr6.png"
theme.arr7 = pathToConfig .. "powerarrowf/icons/arr7.png"
theme.arr8 = pathToConfig .. "powerarrowf/icons/arr8.png"
theme.arr9 = pathToConfig .. "powerarrowf/icons/arr9.png"

-- The clock icon:
theme.clock = pathToConfig .. "powerarrowf/icons/myclocknew.png"

--{{ For the wifi widget icons }} --
theme.nethigh = pathToConfig .. "powerarrowf/icons/nethigh.png"
theme.netmedium = pathToConfig .. "powerarrowf/icons/netmedium.png"
theme.netlow = pathToConfig .. "powerarrowf/icons/netlow.png"

--{{ For the battery icon }} --
theme.baticon = pathToConfig .. "powerarrowf/icons/battery.png"

--{{ For the hard drive icon }} --
theme.fsicon = pathToConfig .. "powerarrowf/icons/hdd.png"

--{{ For the volume icons }} --
theme.mute = pathToConfig .. "powerarrowf/icons/mute.png"
theme.music = pathToConfig .. "powerarrowf/icons/music.png"

--{{ For the volume icon }} --
theme.mute = pathToConfig .. "powerarrowf/icons/volmute.png"
theme.volhi = pathToConfig .. "powerarrowf/icons/volhi.png"
theme.volmed = pathToConfig .. "powerarrowf/icons/volmed.png"
theme.vollow = pathToConfig .. "powerarrowf/icons/vollow.png"

--{{ For the CPU icon }} --
theme.cpuicon = pathToConfig .. "powerarrowf/icons/cpu.png"

--{{ For the memory icon }} --
theme.mem = pathToConfig .. "powerarrowf/icons/mem.png"

--{{ For the memory icon }} --
theme.mail = pathToConfig .. "powerarrowf/icons/mail.png"
theme.mailopen = pathToConfig .. "powerarrowf/icons/mailopen.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.fg_widget_clock = "#B58900"
theme.fg_widget_value = "#E0E0D1"
theme.fg_widget_value_important = "#CB4B16"

return theme
