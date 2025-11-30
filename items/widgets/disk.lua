local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Update with path to stats_provider
sbar.exec('killall stats_provider >/dev/null; /opt/homebrew/bin/stats_provider --disk usage')

-- Subscribe and use the `DISK_USAGE` var
local disk_percent = sbar.add('item', 'widgets.disk1', {
 position = "right",
  icon = {
    drawing = false
  },
  label = { font = { family = settings.font.numbers } },
  padding_left = -1,
  update_freq = 120,
  popup = { align = "center" }
})

local disk_icon = sbar.add("item", "widgets.disk2", {
  position = "right",
  padding_right = -1,
  icon = {
    string = icons.disk,
    width = 0,
    align = "left",
    color = colors.white,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
  label = {
    width = 25,
    align = "left",
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
})

disk_percent:subscribe('system_stats', function(env)
	disk_percent:set { label = env.DISK_USAGE }
end)

sbar.add("bracket", "widgets.disk.bracket", { 
    disk_icon.name,
    disk_percent.name 
}, {
  background = { color = colors.bg1 }
})

sbar.add("item", "widgets.disk.padding", {
  position = "right",
  width = settings.group_paddings
})

disk_percent:subscribe("mouse.clicked", function(env)
  sbar.exec("open 'x-apple.systempreferences:com.apple.settings.Storage'")
end)
