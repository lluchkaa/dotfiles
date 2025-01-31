-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local color_scheme = "Catppuccin Mocha"
config.color_scheme = color_scheme

config.font_size = 13.0
config.font = wezterm.font_with_fallback({
	{
		family = "Monaspace Krypton Var",
		-- harfbuzz_features = {
		-- 	"calt=1",
		-- 	"clig=1",
		-- 	"dlig=1",
		-- 	"liga=1",
		-- 	"ss01=1",
		-- 	"ss02=1",
		-- 	"ss03=1",
		-- 	"ss04=1",
		-- 	"ss05=1",
		-- 	"ss06=1",
		-- 	"ss07=1",
		-- 	"ss08=1",
		-- },
	},
	{ family = "FiraCode Nerd Font" },
})

config.hide_tab_bar_if_only_one_tab = true

local default_window_padding = {
	top = "2cell",
	bottom = 0,
	left = 0,
	right = 0,
}

config.window_padding = default_window_padding
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

local function recompute_padding(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	local top_padding = window_dims.is_full_screen and 0 or "2cell"

	if overrides.window_padding and overrides.window_padding.top == top_padding then
		return
	end

	overrides.window_padding = {
		top = top_padding,
		bottom = default_window_padding.bottom,
		left = default_window_padding.left,
		right = default_window_padding.right,
	}

	window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, pane)
	recompute_padding(window)
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- and finally, return the configuration to wezterm
return config
