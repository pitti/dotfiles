-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("vicious")

require("menubar")

require("vain")

menubar.cache_entries = true
menubar.app_folders = { "/usr/share/applications/", "~/.local/share/applications/" }
menubar.show_categories = false

beautiful.init( awful.util.getdir("config") .. "/themes/mycol/theme.lua" )


-- This is used later as the default terminal and editor to run.
wibox_height = 12
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

vain.widgets.terminal = terminal


-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,            -- 1
    awful.layout.suit.floating,        -- 2
    awful.layout.suit.tile.left,       -- 3
    awful.layout.suit.tile.bottom,     -- 4
    awful.layout.suit.tile.top,        -- 5
    awful.layout.suit.fair,            -- 6
    awful.layout.suit.fair.horizontal, -- 7
}

-- Define a tag table which hold all screen tags.
tags = {}


-- Spawn rules for browser and mail
mailtag = 2
webtag  = 1

-- TODO: Read this from file
if screen.count() > 1 then
  screentags =  {
    {
      names = {"1:web", "2:mail", "3", "4", "5", "6", "7", "8:fs", "9:music"},
      layouts = { 1, 1, 1, 1, 1, 1, 1, 2, 1}
    },
    {
      names = {"1:im", "2", "3", "4", "5", "6", "7", "8", "9"},
      layouts = { 2, 1, 1, 1, 1, 1, 1, 1, 1}
    }
  }

  imtag = 1
  skypetag = 2

else

  screentags =  {
    {
      names = {"web", "mail", "3", "4", "5", "6", "im", "fs", "music"},
      layouts = { 1, 1, 1, 1, 1, 1, 2, 2, 1}
    }
  }

  imtag = 7
  skypetag = 7

end

for s = 1, screen.count() do
	for l = 1, #screentags[s].layouts do
		screentags[s].layouts[l] = layouts[screentags[s].layouts[l]]
	end
	-- Each screen has its own tag table.
	tags[s] = awful.tag(screentags[s].names, s, screentags[s].layouts)
end

awful.layout.set(vain.layout.termfair, tags[1][3])
awful.tag.setnmaster(2, tags[1][3])
awful.tag.setncol(1, tags[1][3])


-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ 
                          items = { 
                            { "awesome", myawesomemenu, beautiful.awesome_icon },
                            { "open terminal", terminal } 
                          }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

local spacer    = widget({ type = "textbox", name = "spacer" })
local separator = widget({ type = "textbox", name = "separator" })

spacer.text    = " "
separator.text = " <span foreground='" .. beautiful.border_normal .. "'>•</span> "

-- CPU usage and temperature
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)

cpugraph  = awful.widget.graph()

cpugraph:set_width(40):set_height(wibox_height)
cpugraph:set_background_color(beautiful.bg_widget)
cpugraph:set_color(beautiful.fg_widget)

vicious.register(cpugraph,  vicious.widgets.cpu,      "$1")

-- Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

membar = awful.widget.progressbar()

membar:set_vertical(true):set_ticks(true)
membar:set_height(wibox_height):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.bg_widget)
membar:set_color(beautiful.fg_widget)

vicious.register(membar, vicious.widgets.mem, "$1", 13)


-- Battery usage 
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)

-- Network usage
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon.image = image(beautiful.widget_netup)

netwidget = widget({ type = "textbox" })

vicious.register(netwidget, vicious.widgets.net, '<span color="'
  .. beautiful.fg_netdn_widget ..'">${lan0 down_kb}</span> <span color="'
  .. beautiful.fg_netup_widget ..'">${lan0 up_kb}</span>', 3)


-- Clock
mytextclock = awful.widget.textclock({ align = "right" })

-- Systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
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
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

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

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = wibox_height, screen = s })
    -- Add widgets to the wibox below
    if screen.count() > 1 then
      if s == 1 then
        mywibox[s].widgets = {
          {
            mytaglist[s], separator,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
          },
          mylayoutbox[s],
          separator, mytextclock,
          -- separator, volwidget,
          separator, mytasklist[s],
          layout = awful.widget.layout.horizontal.rightleft
        }
      end

      if s == 2 then
        mywibox[s].widgets = {
          {
            mytaglist[s], separator,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
          },
          mylayoutbox[s],
          separator, mytextclock,
          separator, mysystray, 
          separator, membar.widget, memicon,
          separator, cpugraph.widget, cpuicon,
          separator, upicon, netwidget, dnicon,
          separator, mytasklist[s],
          layout = awful.widget.layout.horizontal.rightleft
        }
      end
      -- non-dualhead config
    else
        mywibox[s].widgets = {
          {
            mytaglist[s], separator,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
          },
          mylayoutbox[s],
          separator, mytextclock,
          mysystray,
          separator, membar.widget, memicon,
          separator, cpugraph.widget, cpuicon,
          separator, upicon, netwidget, dnicon,
          -- separator, volwidget,
          separator, mytasklist[s],
          layout = awful.widget.layout.horizontal.rightleft
        }

    end

end

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    -- awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",
              function ()
                  local theme = beautiful.get()
                  local bg = nil
                  local fg = nil
                  local t = awful.tag.selected(scr)
                  local scr = t.screen

                  local tagname = t.name

                  if t.name:find(":") then
                    tagname = t.name:sub(t.name:find(":") + 1)
                  end

                  awful.prompt.run(
                    {
                      prompt = "new tag name: ",
                      text = tagname,
                      selectall = true
                    },
                    mypromptbox[mouse.screen].widget,
                    function (name) if name:len() > 0 then t.name = awful.tag.getidx(t) .. ":" .. name; end end,
                    nil,
                    awful.util.getdir("cache") .. "/history_tags")
              end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

   awful.key( { }, "XF86AudioPrev", function () awful.util.spawn("cmus-remote -r", false) end),
   awful.key( { }, "XF86AudioNext", function () awful.util.spawn("cmus-remote -n", false) end),
   awful.key( { }, "XF86AudioPlay", function () awful.util.spawn("cmus-remote -u", false) end),

   awful.key( { }, "XF86PowerOff", function () awful.util.spawn("sudo pm-suspend", false) end),

   awful.key( { modkey, "Control" }, "p", function () awful.util.spawn_with_shell("~/.local/bin/slock-with-pidgin", false) end),

   awful.key( { }, "XF86AudioMute",        function () awful.util.spawn("dvol -t", false)end),
   awful.key( { }, "XF86AudioRaiseVolume", function () awful.util.spawn("dvol -i 5", false) end),
   awful.key( { }, "XF86AudioLowerVolume", function () awful.util.spawn("dvol -d 5", false) end)
   -- awful.key( { modkey }, "space", function () menubar.show() end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules,
--
--
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
    { rule = { class = "Pidgin" },      properties = { tag = tags[screen.count()][imtag]}},
    { rule = { class = "Skype" },       properties = { tag = tags[screen.count()][imtag]}},
    { rule = { class = "Thunderbird" }, properties = { tag = tags[1][mailtag]}},
    { rule = { class = "Chromium" },    properties = { tag = tags[1][webtag]}},
    -- Fullscreen Flash Video
    { rule = { class = "Exe"}, properties = {floating = true} },


    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--
--
-- vim: set et :
