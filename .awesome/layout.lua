-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
}

-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    --tags[s] = awful.tag({ "web", "dev", "chat", "music", "fs", "art" }, s, layouts[1])
    --tags[s] = awful.tag({ "1", "2", "3", "4", "5", "6" }, s, layouts[1])
    --tags[s] = awful.tag({ "木", "火", "土", "水", "金" }, s, layouts[1])
    tags[s] = awful.tag({ "1", "2" }, s, layouts[1])
    --tags[s] = awful.tag({ "月", "火", "水", "木", "金" , "土" , "日" }, s, layouts[1])
    --tags[s] = awful.tag({ "一", "二", "三", "四", "五" }, s, layouts[1])
end
