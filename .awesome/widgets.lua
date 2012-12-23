separator = widget({ type = "textbox" })
separator.text  = " │ "
blank = widget({ type = "textbox" })
blank.text  = " "
bar = widget({ type = "textbox" })
bar.text  = "│"

datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%a %Y-%m-%d %H:%M", 60)

wifi = widget({ type = "textbox" })
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

cpuwidget = widget({ type = "textbox" })
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

volume = widget({ type = "textbox" })
vicious.register(volume, vicious.widgets.volume, "$1$2", 60, "Master")

battery = widget({ type = "textbox" })
vicious.register(battery, vicious.widgets.bat, " $3$1", 60, "BAT0")
battery2 = widget({ type = "textbox" })
vicious.register(battery2, vicious.widgets.bat, "$3$1", 60, "BAT1")

weather = widget({ type = "textbox" })
vicious.register(weather, vicious.widgets.weather, "${tempc}°C", 600, "EDVE")

mysystray = widget({ type = "systray" })

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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "25", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        datewidget,
        separator,
        battery,
        battery2,
        separator,
        volume,
        separator,
        wifi,
        separator,
        weather,
        blank,
        bar,
        --netwidget.widget,
        --bar,
        cpuwidget,
        bar,
        blank,
        s == 1 and mysystray or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
