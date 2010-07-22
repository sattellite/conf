---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "terminus 9"

theme.bg_normal     = "#e0e0e0"
theme.bg_focus      = "#707070"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#585858"

theme.fg_normal     = "#585858"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#707070"
theme.border_marked = "#91231c"

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
theme.taglist_squares_sel   = "/home/sattellite/.config/awesome/mytheme/taglist/squarefg.png"
theme.taglist_squares_unsel = "/home/sattellite/.config/awesome/mytheme/taglist/squareg.png"

theme.tasklist_floating_icon = "/home/sattellite/.config/awesome/mytheme/tasklist/floatingg.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/sattellite/.config/awesome/mytheme/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/sattellite/.config/awesome/mytheme/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/sattellite/.config/awesome/mytheme/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/sattellite/.config/awesome/mytheme/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/sattellite/.config/awesome/mytheme/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/sattellite/.config/awesome/mytheme/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/sattellite/.config/awesome/mytheme/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/sattellite/.config/awesome/mytheme/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/sattellite/.config/awesome/mytheme/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/sattellite/.config/awesome/mytheme/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/sattellite/.config/awesome/mytheme/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/sattellite/.config/awesome/mytheme/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/sattellite/.config/awesome/mytheme/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/sattellite/.config/awesome/mytheme/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/sattellite/.config/awesome/mytheme/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/sattellite/.config/awesome/mytheme/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/sattellite/.config/awesome/mytheme/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/sattellite/.config/awesome/mytheme/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/sattellite/.config/awesome/mytheme/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/sattellite/.config/awesome/mytheme/background.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/sattellite/.config/awesome/mytheme/layouts/fairhg.png"
theme.layout_fairv = "/home/sattellite/.config/awesome/mytheme/layouts/fairvg.png"
theme.layout_floating  = "/home/sattellite/.config/awesome/mytheme/layouts/floatingg.png"
theme.layout_magnifier = "/home/sattellite/.config/awesome/mytheme/layouts/magnifierg.png"
theme.layout_max = "/home/sattellite/.config/awesome/mytheme/layouts/maxg.png"
theme.layout_fullscreen = "/home/sattellite/.config/awesome/mytheme/layouts/fullscreeng.png"
theme.layout_tilebottom = "/home/sattellite/.config/awesome/mytheme/layouts/tilebottomg.png"
theme.layout_tileleft   = "/home/sattellite/.config/awesome/mytheme/layouts/tileleftg.png"
theme.layout_tile = "/home/sattellite/.config/awesome/mytheme/layouts/tileg.png"
theme.layout_tiletop = "/home/sattellite/.config/awesome/mytheme/layouts/tiletopg.png"
theme.layout_spiral  = "/home/sattellite/.config/awesome/mytheme/layouts/spiralg.png"
theme.layout_dwindle = "/home/sattellite/.config/awesome/mytheme/layouts/dwindleg.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
