
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS NF")

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = 'DoomOne'

-- Initial opacity value
local opacity = 0.9;
config.window_background_opacity = opacity;

wezterm.on('increase-opacity', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	opacity = math.min(1.0, opacity + 0.1)
	overrides.window_background_opacity = opacity;
	window:set_config_overrides(overrides)
	end
)

wezterm.on('decrease-opacity', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	opacity = math.max(0.1, opacity - 0.1)
	overrides.window_background_opacity = opacity;
	window:set_config_overrides(overrides)
	end
)

config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1000 }
config.keys = {
    -- PANES
    {
        key = 'v',
        mods = 'ALT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    }, 
    {
        key = 's',
        mods = 'ALT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    }, 
    {
        key = 'h',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'H',
        mods = 'ALT',
        action = act.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'J',
        mods = 'ALT',
        action = act.AdjustPaneSize { 'Down', 5 },
    },
    { key = 'K', mods = 'ALT', action = act.AdjustPaneSize { 'Up', 5 } },
    {
        key = 'L',
        mods = 'ALT',
        action = act.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'q',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- BACKGROUND OPACITY
    {
        mods = 'CTRL|SHIFT',
        key = 'o',
        action = wezterm.action.EmitEvent 'increase-opacity',
    },
    {
        mods = 'CTRL|SHIFT',
        key = 'i',
        action = wezterm.action.EmitEvent 'decrease-opacity',
    },
    {
      key = 's',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane {
	direction = 'Right',
	command = { args = { 'pwsh', '-WorkingDirectory', '~' }	},
      }
    },
    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitPane {
	direction = 'Right',
	command = { args = { 'wsl', '~' } },
      }
    }
}

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.keys = {
  {
    key = '9',
    mods = 'ALT',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  { key = 'n', mods = 'CTRL', action = act.SwitchWorkspaceRelative(1) },
  { key = 'p', mods = 'CTRL', action = act.SwitchWorkspaceRelative(-1) },
}

-- wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
--  local args = {}
--  if cmd then
--    args = cmd.args
--  end

  -- Set a workspace for coding on a current project
  -- Top pane is for the editor, bottom pane is for the build tool
--  local tab, build_pane, window = mux.spawn_window {
--    workspace = 'monitoring',
--    args = { 'btop' },
--  }
--  window:gui_window():maximize()

  -- We want to startup in the coding workspace
--  mux.set_active_workspace 'monitoring'
--end)

config.launch_menu = {
	{
		args = { 'pwsh' },
		cwd = '~'
        },
	{
		-- Optional label to show in the launcher. If omitted, a label
	     	-- is derived from the `args`
		-- label = 'wsl',
		-- The argument array to spawn.  If omitted the default program
		-- will be used as described in the documentation above
		args = { 'wsl' },
		-- You can specify an alternative current working directory;
		-- if you don't specify one then a default based on the OSC 7
		-- escape sequence will be used (see the Shell Integration
		-- docs), falling back to the home directory.
--		cwd = '~'
		-- You can override environment variables just for this command
		-- by setting this here.  It has the same semantics as the main
		-- set_environment_variables configuration option described above
		-- set_environment_variables = { FOO = "bar" },
	},
}


-- Spawn a pwsh shell in login mode
--config.default_prog = {'pwsh'}
--
config.ssh_domains = {
	{
		name = 'wsl',
		username = 'fpereir',
		remote_address = '172.18.139.139',
		multiplexing = 'None',
		default_prog = { 'zsh' },
		assume_shell = 'Posix',
	}
}
config.default_domain = 'wsl'


return config
