separator = wibox.widget.textbox()
separator:set_text(" │ ")

datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "%a %Y-%m-%d %H:%M", 60)

function ip_line()
    local f = io.popen("ip addr show wlan0 | grep 'inet ' | cut -d' ' -f6")
    local l = f:lines()
    local v = ''
    for line in l do
        v = line
    end
    if v == '' then
        v = "offline"
    end
    return {v}
end

ipwidget = wibox.widget.textbox()
vicious.register(ipwidget, ip_line, "$1", 60)

function battery_line()
    local f = io.popen("battery-status")
    local l = f:lines()
    local v = ''
    for line in l do
        v = line
    end
    return {v}
end

battery = wibox.widget.textbox()
vicious.register(battery, battery_line, "$1", 60)

--cpuwidget = awful.widget.graph()
--cpuwidget:set_width(100)
--cpuwidget:set_height(25)
--cpuwidget:set_background_color("#000000")
--cpuwidget:set_color("#FFFFFF")
--vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 0.5)

--netwidget = awful.widget.graph()
--netwidget:set_width(100)
--netwidget:set_height(25)
--netwidget:set_background_color("#000000")
--netwidget:set_max_value(4)
--netwidget:set_color("#96cbfe")
--vicious.register(netwidget, vicious.widgets.net,
--                    function (widget, args)
--                        return args["{wlan0 down_kb}"]
--                    end, 0.5)

volume = wibox.widget.textbox()
vicious.register(volume, vicious.widgets.volume, "$1$2", 60, "Master")

mysystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
mywibox = {}
mywibox2 = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
)

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "25", screen = s })

    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(mytaglist[s])
    if s == 1 then
        left_layout:add(mysystray)
    end
    left_layout:add(mypromptbox[s])

    local right_layout = wibox.layout.fixed.horizontal()

    right_layout:add(ipwidget)
    right_layout:add(separator)
    right_layout:add(volume)
    right_layout:add(separator)
    right_layout:add(battery)
    right_layout:add(separator)
    right_layout:add(datewidget)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    mywibox[s].visible = false
end
