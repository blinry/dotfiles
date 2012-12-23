awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
    properties = { size_hints_honor = false,
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    focus = true,
    keys = clientkeys,
    buttons = clientbuttons } },

    { rule = { class = "Firefox" }, properties = { tag = tags[1][1] } },

    { rule = { class = "Pidgin" }, properties = { tag = tags[1][3] } },
    { rule = { class = "Transmission-gtk" }, properties = { tag = tags[1][3] } },

    { rule = { class = "Quodlibet" }, properties = { tag = tags[1][4] } },

    { rule = { class = "Vlc" }, properties = { tag = tags[1][5] } },

    { rule = { class = "Gimp" }, properties = { tag = tags[1][6] } },
    { rule = { class = "Inkscape" }, properties = { tag = tags[1][6] } },
}
