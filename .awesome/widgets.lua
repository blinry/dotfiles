function status_line()
    local f = io.popen("status-line")
    local l = f:lines()
    local v = ''
    for line in l do
        v = line
    end
    return {v}
end

status = wibox.widget.textbox()
vicious.register(status, status_line, "$1", 60)

mpd = wibox.widget.textbox()
vicious.register(mpd, vicious.widgets.mpd, function (widget, args)
    if args["{state}"] ~= "Play" then 
        return ""
    else 
        local l = args["{Artist}"]..' - '..args["{Album}"]..' - '..args["{Title}"]..' │ '
        local max_length = 64
        if string.len(l) > max_length then
            l = '…'..l:sub(-(max_length-1))
        end
        return l
    end
end, 10)

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
    left_layout:add(mypromptbox[s])

    local right_layout = wibox.layout.fixed.horizontal()

    right_layout:add(mpd)
    if s == 1 then
        right_layout:add(mysystray)
    end
    right_layout:add(status)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    mywibox[s].visible = true
end
