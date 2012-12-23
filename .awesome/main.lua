require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
vicious = require("vicious")

terminal = "urxvt"
modkey = "Mod1"

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local conf_dir = os.getenv("HOME") .. "/.awesome/"

dofile(conf_dir .. "layout.lua")

dofile(conf_dir .. "bindings.lua")
if file_exists(conf_dir .. "bindings.lua.local") then
    dofile(conf_dir .. "bindings.lua.local")
end
root.keys(globalkeys)

beautiful.init(conf_dir .. "theme.lua")
dofile(conf_dir .. "rules.lua")
dofile(conf_dir .. "signals.lua")

dofile(conf_dir .. "widgets.lua")
if file_exists(conf_dir .. "widgets.lua.local") then
    dofile(conf_dir .. "widgets.lua.local")
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
        title = "Awesome error!",
        text = err })
        in_error = false
    end)
end
