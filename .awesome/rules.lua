awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            size_hints_honor = false,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = true,
            keys = clientkeys,
            buttons = clientbuttons
        }
    }
}
