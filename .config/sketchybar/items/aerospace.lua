-- items/workspaces.lua
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local query_workspaces =
	"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"

-- Add padding to the left
local root = sbar.add("item", {
	icon = {
		color = colors.with_alpha(colors.white, 0.3),
		highlight_color = colors.white,
		drawing = false,
	},
	label = {
		color = colors.grey,
		highlight_color = colors.white,
		drawing = false,
	},
	background = {
		color = colors.transparent,
		border_width = 0,
		height = 26,
		border_color = colors.black,
		corner_radius = 0,
		drawing = false,
	},
	padding_left = 6,
	padding_right = 0,
})

local workspaces = {}
local focused_workspace = nil  -- Track currently focused workspace

local function withWindows(f)
  local open_windows = {}
	local get_windows = "aerospace list-windows --monitor all --format '%{workspace}%{app-name}' --json"
	local query_visible_workspaces = "aerospace list-workspaces --visible --monitor all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
	local get_focus_workspaces = "aerospace list-workspaces --focused"
  sbar.exec(get_windows, function(workspace_and_windows)
    for _, entry in ipairs(workspace_and_windows) do
      local workspace_index = entry.workspace
      local app = entry["app-name"]
      if open_windows[workspace_index] == nil then
        open_windows[workspace_index] = {}
      end
      table.insert(open_windows[workspace_index], app)
    end
    sbar.exec(get_focus_workspaces, function(focused_workspaces)
      sbar.exec(query_visible_workspaces, function(visible_workspaces)
        local args = { open_windows = open_windows, focused_workspaces = focused_workspaces, visible_workspaces = visible_workspaces }
        f(args)
      end)
    end)
  end)
end

local function updateWindow(workspace_index, args)
    local open_windows = args.open_windows[workspace_index] or {}
    local icon_line = ""
    local has_apps = #open_windows > 0
    if has_apps then
        local first_app = open_windows[1]
        local lookup = app_icons[first_app]
        local icon = ((lookup == nil) and app_icons["Default"] or lookup)
        icon_line = " " .. icon

        -- Attempt to use the focused workspace's icon if available
        if #open_windows > 0 then
            for _, app in ipairs(open_windows) do
                local lookup_focus = app_icons[app]
                local candidate = ((lookup_focus == nil) and app_icons["Default"] or lookup_focus)
                icon_line = " " .. candidate
                break
            end
        end
    end

    local show_item = true  -- Always show workspaces (persistent-workspaces enabled)
    local label_should_draw = has_apps and icon_line ~= ""
    
    -- Determine background color and icon/label colors based on workspace state
    local is_focused = (focused_workspace == workspace_index)
    local workspace_num = tonumber(workspace_index)
    local bg_color
    local icon_color
    local label_color
    
    if is_focused then
        -- Active workspace: use pastel color for background, dark color for icon/label (for visibility)
        bg_color = colors.workspace_colors[workspace_num] or colors.bg3
        icon_color = colors.black  -- Dark color for workspace number
        label_color = colors.black  -- Dark color for app icon
    elseif has_apps then
        -- Inactive but has apps: grayish background, default colors for icon/label
        bg_color = colors.bg3
        icon_color = colors.with_alpha(colors.white, 0.3)
        label_color = colors.with_alpha(colors.white, 0.3)
    else
        -- Inactive and no apps: transparent background, default colors for icon/label
        bg_color = colors.transparent
        icon_color = colors.with_alpha(colors.white, 0.3)
        label_color = colors.with_alpha(colors.white, 0.3)
    end

    sbar.animate("tanh", 10, function()
        workspaces[workspace_index]:set({
            drawing = show_item,
            icon = {
                drawing = show_item,
                color = icon_color,  -- Use color directly, not highlight
            },
            label = {
                drawing = label_should_draw,
                string = icon_line,
                font = "sketchybar-app-font:Regular:16.0",
                y_offset = -1,
                color = label_color,  -- Use color directly, not highlight
            },
            background = {
                drawing = show_item,
                color = bg_color,
                border_width = 0,  -- No border
            },
            padding_right = 1,
            padding_left = 1,
        })
    end)
end

local function updateWindows()
  withWindows(function(args)
    for workspace_index, _ in pairs(workspaces) do
      updateWindow(workspace_index, args)
    end
  end)
end

local function updateWorkspaceMonitor()
  local workspace_monitor = {}
  sbar.exec(query_workspaces, function(workspaces_and_monitors)
    table.sort(workspaces_and_monitors, function(a, b)
      return tonumber(a.workspace) < tonumber(b.workspace)
    end)
    for _, entry in ipairs(workspaces_and_monitors) do
      local space_index = entry.workspace
      local monitor_id = math.floor(entry["monitor-appkit-nsscreen-screens-id"])
      workspace_monitor[space_index] = monitor_id
    end
    for workspace_index, _ in pairs(workspaces) do
      workspaces[workspace_index]:set({
        display = workspace_monitor[workspace_index],
      })
    end
	end)
end

sbar.exec(query_workspaces, function(workspaces_and_monitors)
    table.sort(workspaces_and_monitors, function(a, b)
        return tonumber(a.workspace) < tonumber(b.workspace)
    end)
    for _, entry in ipairs(workspaces_and_monitors) do
        local workspace_index = entry.workspace

        local workspace = sbar.add("item", {
            width = 55,  -- Fixed width for uniform workspace items
            icon = {
                color = colors.with_alpha(colors.white, 0.3),
                -- highlight_color = colors.red,
                highlight_color = colors.white,
                drawing = false,
                font = { family = settings.font.numbers },
                string = workspace_index,
                padding_left = 10,
                padding_right = 2,
            },
            label = {
                padding_right = 10,
                -- color = colors.grey,
                color = colors.with_alpha(colors.white, 0.3),
                highlight_color = colors.white,
                font = "sketchybar-app-font:Regular:16.0",
                y_offset = -1,
            },
            padding_right = 2,
            padding_left = 2,
            background = {
                color = colors.bg3,
                border_width = 0,  -- No border on workspace item itself
                height = 26,
                corner_radius = 0,  -- No rounded corners
            },
            click_script = "aerospace workspace " .. workspace_index,
        })

        workspaces[workspace_index] = workspace

        workspace:subscribe("aerospace_workspace_change", function(env)
            local new_focused_workspace = env.FOCUSED_WORKSPACE
            focused_workspace = new_focused_workspace  -- Update global focused workspace
            local is_focused = new_focused_workspace == workspace_index
            local workspace_num = tonumber(workspace_index)

            -- Determine background color and icon/label colors
            -- Check if workspace has apps by calling updateWindows to get current state
            withWindows(function(args)
                local open_windows = args.open_windows[workspace_index] or {}
                local has_apps = #open_windows > 0
                local bg_color
                local icon_color
                local label_color
                
                if is_focused then
                    -- Active workspace: use pastel color for background, dark color for icon/label (for visibility)
                    bg_color = colors.workspace_colors[workspace_num] or colors.bg3
                    icon_color = colors.black  -- Dark color for workspace number
                    label_color = colors.black  -- Dark color for app icon
                elseif has_apps then
                    -- Inactive but has apps: grayish background, default colors for icon/label
                    bg_color = colors.bg3
                    icon_color = colors.with_alpha(colors.white, 0.3)
                    label_color = colors.with_alpha(colors.white, 0.3)
                else
                    -- Inactive and no apps: transparent background, default colors for icon/label
                    bg_color = colors.transparent
                    icon_color = colors.with_alpha(colors.white, 0.3)
                    label_color = colors.with_alpha(colors.white, 0.3)
                end

                sbar.animate("tanh", 10, function()
                    workspace:set({
                        icon = {
                            color = icon_color,  -- Use color directly, not highlight
                        },
                        label = {
                            color = label_color,  -- Use color directly, not highlight
                        },
                        background = {
                            color = bg_color,
                            border_width = 0,  -- No border
                        },
                    })
                end)
            end)
        end)
    end

    -- initial setup - get focused workspace first
    sbar.exec("aerospace list-workspaces --focused", function(focused_ws)
      focused_workspace = focused_ws:match("^%s*(.-)%s*$")
      updateWindows()
      updateWorkspaceMonitor()
    end)

    root:subscribe("aerospace_focus_change", function()
      -- Update focused workspace when focus changes
      sbar.exec("aerospace list-workspaces --focused", function(focused_ws)
        focused_workspace = focused_ws:match("^%s*(.-)%s*$")
        updateWindows()
      end)
    end)

    root:subscribe("display_change", function()
      updateWorkspaceMonitor()
      updateWindows()
    end)
end)
