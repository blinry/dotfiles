separator = wibox.widget.textbox()
separator:set_text(" │ ")
blank = wibox.widget.textbox()
blank:set_text(" ")
bar = wibox.widget.textbox()
bar:set_text("│")

datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "%a %Y-%m-%d %H:%M", 60)

wifi = wibox.widget.textbox()
vicious.register(wifi, vicious.widgets.wifi, "${ssid}:${link}", 60, "wlan0")

function load_line()
    local f = io.popen("cat /proc/loadavg | cut -d' ' -f1-3")
    local l = f:lines()
    local v = ''
    for line in l do
        v = line
    end
    return {v}
end

cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, load_line, " $1 ", 60)

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

battery = wibox.widget.textbox()
vicious.register(battery, vicious.widgets.bat, "$3$1", 60, "BAT0")
--battery2 = wibox.widget.textbox()
--vicious.register(battery2, vicious.widgets.bat, "$3$1", 60, "BAT1")

weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather, "${tempc}°C", 600, "EDVE")

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
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    local right_layout = wibox.layout.fixed.horizontal()

    if s == 1 then
        right_layout:add(mysystray)
        right_layout:add(bar)
    end

    right_layout:add(cpuwidget)
    right_layout:add(bar)
    right_layout:add(blank)
    right_layout:add(weather)
    right_layout:add(separator)
    right_layout:add(wifi)
    right_layout:add(separator)
    right_layout:add(volume)
    right_layout:add(separator)
    right_layout:add(datewidget)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    mywibox[s].visible = false
end
