local config = require("config/base")

---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- Colors
theme.colors			= {}
theme.colors.base3		= "#002b36"
theme.colors.base2		= "#073642"
theme.colors.base1		= "#586e75"
theme.colors.base0		= "#657b83"
theme.colors.base00		= "#839496"
theme.colors.base01		= "#93a1a1"
theme.colors.base02		= "#eee8d5" 
theme.colors.base03		= "#fdf6e3"
theme.colors.yellow		= "#b58900" 
theme.colors.orange		= "#cb4b16"  
theme.colors.red		= "#dc322f"   
theme.colors.magenta	= "#d33682"    
theme.colors.violet		= "#6c71c4"
theme.colors.blue		= "#268bd2"
theme.colors.cyan		= "#2aa198"
theme.colors.green		= "#859900"
theme.colors.dviolet	= "#4B3B51"
--

pathToConfig				= config.home .. "/.config/awesome/"
theme.default_themes_path	= "/usr/share/awesome/themes"

theme.font	= "Inconsolata 9"

theme.bg_normal		= theme.colors.base3
theme.bg_focus		= theme.colors.base1
theme.bg_urgent		= theme.colors.red
theme.bg_systray	= theme.colors.dviolet

theme.fg_normal	= theme.colors.base02
theme.fg_focus	= theme.colors.base03
theme.fg_urgent	= theme.colors.base3

theme.border_width	= "2"
theme.border_normal	= theme.colors.base2
theme.border_focus	= theme.bg_focus
theme.border_marked	= theme.bg_urgent

theme.titlebar_bg_focus		= theme.bg_focus
theme.titlebar_bg_normal	= theme.bg_normal

theme.mouse_finder_color	= theme.colors.green
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
theme.taglist_squares_sel	= theme.default_themes_path.."/zenburn/taglist/squarefz.png" 
theme.taglist_squares_unsel	= theme.default_themes_path.."/zenburn/taglist/squarez.png" 

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.awesome_icon		= theme.default_themes_path .. "/zenburn/awesome-icon.png"
theme.menu_submenu_icon	= theme.default_themes_path .. "/default/submenu.png"
theme.menu_launch		= pathToConfig .. "themes/solarized-dark/icons/launch.png"
theme.menu_terminal		= pathToConfig .. "themes/solarized-dark/icons/terminal.png"
theme.menu_vivaldi		= pathToConfig .. "themes/solarized-dark/icons/vivaldi.png"
theme.menu_height		= 15
theme.menu_width		= 100

-- Define the image to load
theme.titlebar_close_button_focus	= theme.default_themes_path.."/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal	= theme.default_themes_path.."/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active	= theme.default_themes_path.."/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active	= theme.default_themes_path.."/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive	= theme.default_themes_path.."/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive	= theme.default_themes_path.."/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active		= theme.default_themes_path.."/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active		= theme.default_themes_path.."/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive		= theme.default_themes_path.."/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive	= theme.default_themes_path.."/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active		= theme.default_themes_path.."/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active	= theme.default_themes_path.."/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive	= theme.default_themes_path.."/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive	= theme.default_themes_path.."/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active	= theme.default_themes_path.."/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active	= theme.default_themes_path.."/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive	= theme.default_themes_path.."/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive	= theme.default_themes_path.."/zenburn/titlebar/maximized_normal_inactive.png"


-- You can use your own layout icons like this:
theme.layout_tile		= theme.default_themes_path .. "/zenburn/layouts/tile.png"
theme.layout_tileleft	= theme.default_themes_path .. "/zenburn/layouts/tileleft.png"
theme.layout_tilebottom	= theme.default_themes_path .. "/zenburn/layouts/tilebottom.png"
theme.layout_tiletop	= theme.default_themes_path .. "/zenburn/layouts/tiletop.png"
theme.layout_fairv		= theme.default_themes_path .. "/zenburn/layouts/fairv.png"
theme.layout_fairh		= theme.default_themes_path .. "/zenburn/layouts/fairh.png"
theme.layout_spiral		= theme.default_themes_path .. "/zenburn/layouts/spiral.png"
theme.layout_dwindle	= theme.default_themes_path .. "/zenburn/layouts/dwindle.png"
theme.layout_max		= theme.default_themes_path .. "/zenburn/layouts/max.png"
theme.layout_fullscreen	= theme.default_themes_path .. "/zenburn/layouts/fullscreen.png"
theme.layout_magnifier	= theme.default_themes_path .. "/zenburn/layouts/magnifier.png"
theme.layout_floating	= theme.default_themes_path .. "/zenburn/layouts/floating.png"


--{{ For the Dark Theme }} --

theme.arr1	= pathToConfig .. "themes/solarized-dark/icons/arr1.png"
theme.rra1	= pathToConfig .. "themes/solarized-dark/icons/rra1.png"
theme.arr2	= pathToConfig .. "themes/solarized-dark/icons/arr2.png"
theme.rra2	= pathToConfig .. "themes/solarized-dark/icons/rra2.png"
theme.arr3	= pathToConfig .. "themes/solarized-dark/icons/arr3.png"
theme.rra3	= pathToConfig .. "themes/solarized-dark/icons/rra3.png"
theme.arr4	= pathToConfig .. "themes/solarized-dark/icons/arr4.png"
theme.rra4	= pathToConfig .. "themes/solarized-dark/icons/rra4.png"
theme.arr5	= pathToConfig .. "themes/solarized-dark/icons/arr5.png"
theme.arr6	= pathToConfig .. "themes/solarized-dark/icons/arr6.png"
theme.arr7	= pathToConfig .. "themes/solarized-dark/icons/arr7.png"
theme.arr8	= pathToConfig .. "themes/solarized-dark/icons/arr8.png"
theme.arr9	= pathToConfig .. "themes/solarized-dark/icons/arr9.png"

-- The clock icon:
theme.clock	= pathToConfig .. "themes/solarized-dark/icons/myclocknew.png"

--{{ For the wifi widget icons }} --
theme.nethigh	= pathToConfig .. "themes/solarized-dark/icons/nethigh.png"
theme.netmedium	= pathToConfig .. "themes/solarized-dark/icons/netmedium.png"
theme.netlow	= pathToConfig .. "themes/solarized-dark/icons/netlow.png"

--{{ For the battery icon }} --
theme.baticon	= pathToConfig .. "themes/solarized-dark/icons/battery.png"

--{{ For the hard drive icon }} --
theme.fsicon	= pathToConfig .. "themes/solarized-dark/icons/hdd.png"

--{{ For the volume icons }} --
theme.mute	= pathToConfig .. "themes/solarized-dark/icons/mute.png"
theme.music	= pathToConfig .. "themes/solarized-dark/icons/music.png"

--{{ For the volume icon }} --
theme.mute		= pathToConfig .. "themes/solarized-dark/icons/volmute.png"
theme.volhi		= pathToConfig .. "themes/solarized-dark/icons/volhi.png"
theme.volmed	= pathToConfig .. "themes/solarized-dark/icons/volmed.png"
theme.vollow	= pathToConfig .. "themes/solarized-dark/icons/vollow.png"

--{{ For the CPU icon }} --
theme.cpuicon	= pathToConfig .. "themes/solarized-dark/icons/cpu.png"

--{{ For the memory icon }} --
theme.mem = pathToConfig .. "themes/solarized-dark/icons/mem.png"

--{{ For the memory icon }} --
theme.mail = pathToConfig .. "themes/solarized-dark/icons/mail.png"
theme.mailopen = pathToConfig .. "themes/solarized-dark/icons/mailopen.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme	= nil

theme.fg_widget_clock			= "#B58900"
theme.fg_widget_value			= "#E0E0D1"
theme.fg_widget_value_important	= "#CB4B16"

theme.lain_icons				= "/usr/share/awesome/lib/lain/icons/layout/zenburn/"
theme.layout_uselesstile		= theme.default_themes_path .. "/zenburn/layouts/tile.png"
theme.layout_uselesstileleft	= theme.default_themes_path .. "/zenburn/layouts/tileleft.png"
theme.layout_uselesstilebottom	= theme.default_themes_path .. "/zenburn/layouts/tilebottom.png"
theme.layout_uselesstiletop		= theme.default_themes_path .. "/zenburn/layouts/tiletop.png"
theme.layout_uselesspiral		= theme.default_themes_path .. "/zenburn/layouts/spiral.png"
theme.layout_uselessfair		= theme.lain_icons .. "termfair.png"
theme.layout_uselessfairh		= theme.lain_icons .. "termfair.png"
theme.layout_termfair			= theme.lain_icons .. "termfairw.png"
theme.layout_centerfair			= theme.lain_icons .. "centerfair.png"
theme.layout_cascade			= theme.lain_icons .. "cascade.png"
theme.layout_cascadetile		= theme.lain_icons .. "cascadetilew.png"
theme.layout_centerwork			= theme.lain_icons .. "centerwork.png"
theme.layout_centerworkd		= theme.lain_icons .. "centerwork.png"

theme.useless_gap_width	= 20

return theme
