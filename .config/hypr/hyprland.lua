-- tzcrawford hyprland config (lua)

---- Required Arch Linux Packages ----
-- hyprland
-- hyprpaper
-- hyprshot
-- cpio # for hyprpm
-- meson # for hyprpm
-- gcc # for hyprpm
-- ttf-envy-code-r #font I use for hyprland details
-- xremap-hypr-bin # if xmodmap does not work anymore
-- waybar
-- bemenu
-- j4-dmenu-desktop
-- swaylock
-- wl-clipboard
--
---- Required plugins ----
-- The following plugins must be installed and enabled. Execute the following within Hyprland
-- hyprpm add https://github.com/outfoxxed/hy3
-- hyprpm update

-----------------------------------------------------------------------------
-- Programs and definitions
-----------------------------------------------------------------------------

local user = os.getenv("USER") or os.getenv("LOGNAME") or "unknown"

local hostname = os.getenv("HOSTNAME")
if not hostname then
    local handle = io.popen("hostname")
    if handle then
        hostname = handle:read("*l")
        handle:close()
    end
end
hostname = hostname or "unknown"

local home = os.getenv("HOME") or "~"
local scripts = home .. "/scripts"

local font = "EnvyCodeR"
local terminal = "alacritty"
local fileManager = "thunar"
local audioMixer = "pavucontrol"
local music = scripts .. "/no_terminal/musicplayer.sh"
local browser = "qutebrowser --backend webengine"
local printer = "system-config-printer"
local networking = "nm-connection-editor"
local netrefresh = "sudo systemctl restart NetworkManager.service"
local start_program = scripts .. "/dmenu.sh --run -o"
local start_program_desktop = "j4-dmenu-desktop --dmenu=\"" .. scripts .. "/dmenu.sh -o\""

-----------------------------------------------------------------------------
-- Colors
-----------------------------------------------------------------------------

local bg = "rgba(2c2c2e77)" -- dark gray
local fg = "rgba(9f9f9fff)" -- bright silver
local lo = "rgba(ffffffff)" -- pure white
local hi = "rgba(a2e0dcff)" -- cyan-white
local tx = "rgba(040404ff)" -- black
local ia = "rgba(8f8f8fff)" -- medium gray

-- Pywal/template placeholders retained verbatim.
local foreground = "rgb({foreground.strip})"
local background = "rgb({background.strip})"
local wallpaper = "rgb({wallpaper.strip})"

local color0  = "rgb({color0.strip})"
local color1  = "rgb({color1.strip})"
local color2  = "rgb({color2.strip})"
local color3  = "rgb({color3.strip})"
local color4  = "rgb({color4.strip})"
local color5  = "rgb({color5.strip})"
local color6  = "rgb({color6.strip})"
local color7  = "rgb({color7.strip})"
local color8  = "rgb({color8.strip})"
local color9  = "rgb({color9.strip})"
local color10 = "rgb({color10.strip})"
local color11 = "rgb({color11.strip})"
local color12 = "rgb({color12.strip})"
local color13 = "rgb({color13.strip})"
local color14 = "rgb({color14.strip})"
local color15 = "rgb({color15.strip})"

-----------------------------------------------------------------------------
-- Monitors
-----------------------------------------------------------------------------

local monitor1
local monitor2
local monitor3

if hostname == "dirac" then
    monitor1 = "DP-1"
    monitor2 = "DP-3"
    monitor3 = "DP-2"
    
    
    hl.monitor({
        output = monitor1,
        mode = "2560x1440@164.80",
        position = "0x1080",
        scale = 1.066,
        transform = 0,
        bitdepth = 10,
        supports_wide_color = 1,
        supports_hdr = 1,
        sdr_max_luminance = 200,
        min_luminance = 0.005,
        max_luminance = 300,
        max_avg_luminance = 300,
    })
    
    hl.monitor({
        output = monitor2,
        mode = "1920x1080@119.98",
        position = "640x0",
        scale = 1.0,
        transform = 0,
        supports_wide_color = 0,
        supports_hdr = 0,
    })
    
    hl.monitor({
        output = monitor3,
        mode = "1920x1080@60.00",
        position = "2560x0",
        scale = 1.0,
        transform = 0,
        supports_wide_color = 0,
        supports_hdr = 0,
    })
elseif hostname == "faraday" then
    monitor1 = "HDMI-A-1"
    hl.monitor({
        output = monitor1,
        mode = "3840x2160@60.0",
        --mode = "1920x1080@60.0",
        position = "0x0",
        scale = 2.4,
        --scale = 1,
        transform = 0,
        bitdepth = 10,
        supports_wide_color = 1,
        supports_hdr = 1,
        sdr_max_luminance = 200,
        min_luminance = 1,
        max_luminance = 300,
        max_avg_luminance = 300,
    })
elseif hostname == "curie" then
    monitor1 = "eDP-1"
    monitor2 = "HDMI-A-1"
    monitorv2 {
        output = monitor1,
        mode = "1920x1200@60.00",
        position = "0x0",
        scale = 1,
        transform = 0,
        bitdepth = 10,
        supports_wide_color = 0,
        supports_hdr = 0,
    }
    monitorv2 {
        output = monitor2,
        mode = "1366x768@60Hz",
        --position = "1921x0",
        position = "auto",
        scale = 1,
    }
end

-----------------------------------------------------------------------------
-- Environment
-----------------------------------------------------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------------------------------------------------------------
-- Permissions
-----------------------------------------------------------------------------

hl.permission({
    binary = "/usr/(bin|local/bin)/hyprpm",
    type = "plugin",
    mode = "allow",
})

-----------------------------------------------------------------------------
-- Look and feel / input / plugin config
-----------------------------------------------------------------------------

hl.config({
    general = {
        gaps_in = 7,
        gaps_out = 18,
        border_size = 3,
        col = {
            active_border = {
                colors = { lo, lo },
                angle = 45,
            },
            inactive_border = bg,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "hy3",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 to 1.0, 0 means no modification.
        numlock_by_default = true,

        touchpad = {
            natural_scroll = false,
        },
    },
   
    master = {
    -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        --vrr = 2
        vrr = 0,
    },

    ecosystem = {
        no_update_news = true,
        -- enforce_permissions = true,
    },

    plugin = {
        hy3 = {
            -- disable gaps when only one window is onscreen
            -- 0 - always show gaps
            -- 1 - hide gaps with a single window onscreen
            -- 2 - 1 but also show the window border
            -- no_gaps_when_only = 0 # default: 0
            -- no_gaps_when_only was removed from hy3?

            -- policy controlling what happens when a node is removed from a group, leaving only a group
            -- 0 = remove the nested group
            -- 1 = keep the nested group
            -- 2 = keep the nested group only if its parent is a tab group
            node_collapse_policy = 2,

            -- offset from group split direction when only one window is in a group.
            group_inset = 10, -- default: 10

            -- if a tab group will automatically be created for the first window spawned in a workspace
            tab_first_window = false,

            -- tab group settings
            tabs = {
                height = 22, -- height of the tab bar, default: 22
                padding = 6, -- padding between the tab bar and its focused node, default: 6
                from_top = false, -- the tab bar should animate in/out from the top instead of below the window, default: false
                radius = 6, -- radius of tab bar corners, default : 6
                border_width = 3, -- tab bar border width, default: 2
                render_text = true, -- render the window title on the bar, default: true
                text_center = true, -- center the window title, default: true
                text_font = font, -- font to render the window title with, default: Sans
                text_height = 8, -- height of the window title, default: 8
                text_padding = 3, -- left padding of the window title, default: 3

                colors = {
                    active = lo, -- default: rgba(33ccff40)
                    active_border = lo, -- default: rgba(33ccffee)
                    active_text = tx, -- default: rgba(ffffffff)

                    focused = lo, -- default: rgba(60606040)
                    focused_border = lo, -- default: rgba(808080ee)
                    focused_text = tx, -- default: rgba(ffffffff)

                    inactive = bg, -- default: rgba(30303020)
                    inactive_border = bg, -- default: rgba(606060aa)
                    inactive_text = ia, -- default: rgba(ffffffff)

                    urgent = hi, -- default: rgba(ff223340)
                    urgent_border = hi, -- default: rgba(ff2233ee)
                    urgent_text = tx, -- default: rgba(ffffffff)

                    locked = hi, -- default: rgba(90903340)
                    locked_border = hi, -- default: rgba(909033ee)
                    locked_text = tx, -- default: rgba(ffffffff)
                },

                -- if tab backgrounds should be blurred
                -- Blur is only visible when the above colors are not opaque.
                blur = true,

                -- opacity multiplier for tabs
                -- Applies to blur as well as the given colors.
                opacity = 1.0,
            },

            autotile = {
                enable = false,
                ephemeral_groups = true, -- make autotile-created groups ephemeral, default: true
                
                -- if a window would be squished smaller than this width, a vertical split will be created
                -- -1 = never automatically split vertically
                -- 0 = always automatically split vertically
                -- <number> = pixel width to split at
                trigger_width = 0, -- default: 0

                --  if a window would be squished smaller than this height, a horizontal split will be created
                --  -1 = never automatically split horizontally
                --  0 = always automatically split horizontally
                --  <number> = pixel height to split at
                trigger_height = 0, -- default: 0

                -- a space or comma separated list of workspace ids where autotile should be enabled
                -- it was/is possible to create an exception rule by prefixing the definition with "not:"
                workspaces = "all",
            },
        },
    },
})

-----------------------------------------------------------------------------
-- Animations
-----------------------------------------------------------------------------

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 } },
})

hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1.0 } },
})

hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-----------------------------------------------------------------------------
-- Gestures / device
-----------------------------------------------------------------------------

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "up",
    mods = "SUPER",
    scale = 1.5,
    action = "fullscreen",
})
-- These may have came with an older version of hyprland config that I disabled.
--gesture = 3, down, mod: ALT, close
--gesture = 3, left, scale: 1.5, float

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-----------------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------------

local mainMod = "SUPER"

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

-- Defer hy3 lookup until dispatch time. This avoids a config-load error if
-- hyprpm has not loaded hy3 yet.
local function hy3_call(method, ...)
    local args = { ... }

    return function()
        local hy3 = hl.plugin and hl.plugin.hy3
        if not hy3 then
            hl.notification.create({
                text = "hy3 is not loaded",
                timeout = 2500,
                icon = "warning",
            })
            return
        end

        local factory = hy3[method]
        if not factory then
            hl.notification.create({
                text = "hy3 Lua dispatcher unavailable: " .. method,
                timeout = 2500,
                icon = "warning",
            })
            return
        end

        local dispatcher = factory(table.unpack(args))
        if dispatcher ~= nil then
            dispatcher()
        end
    end
end

local function ws_key(n)
    return tostring(n % 10)
end

-----------------------------------------------------------------------------
-- Keybindings: session / launchers
-----------------------------------------------------------------------------

hl.bind(mainMod .. " + CTRL + SHIFT + Escape", hl.dsp.exit())
--bind = $mainMod, XKB_KEY_KP_Separator, exec, hyprctl reload, -- old version disabled
hl.bind(mainMod .. " + SHIFT + r", exec("hyprctl reload")) -- was restart in i3 config
hl.bind(mainMod .. " + SHIFT + c", exec("hyprctl reload")) -- was reload in i3 config
hl.bind(mainMod .. " + F4", hl.dsp.window.close())
hl.bind("CTRL + q", exec(home .. "/scripts/nothing.sh"))

-- Launchers
hl.bind(mainMod .. " + Return", exec(terminal))
hl.bind(mainMod .. " + ALT + grave", exec("dunstctl close-all"))
hl.bind(mainMod .. " + ALT + Space", exec("dunstctl history-pop"))
hl.bind(mainMod .. " + e", exec(fileManager))
hl.bind(mainMod .. " + q", exec(audioMixer))
hl.bind(mainMod .. " + p", exec(printer))
hl.bind(mainMod .. " + SHIFT + p", exec(networking))

hl.bind(mainMod .. " + Print"              , exec("hyprshot --freeze -o \"" .. home .. "\" -m region"))
hl.bind(mainMod .. " + SHIFT + Print"      , exec("hyprshot --freeze -o \"" .. home .. "\" -m active -m window"))
hl.bind(mainMod .. " + CTRL + Print"       , exec("hyprshot --freeze -o \"" .. home .. "\" -m active -m output"))
hl.bind(mainMod .. " + ALT + Print"        , exec("hyprshot --freeze --clipboard-only -m region"))
hl.bind(mainMod .. " + ALT + SHIFT + Print", exec("hyprshot --freeze --clipboard-only -m active -m window"))
hl.bind(mainMod .. " + ALT + CTRL + Print" , exec("hyprshot --freeze --clipboard-only -m active -m output"))

hl.bind(mainMod .. " + F1", exec(start_program_desktop))
hl.bind(mainMod .. " + F8", exec(start_program))
hl.bind(mainMod .. " + F2", exec(scripts .. "/no_terminal/scriptstart_noterminal.sh"))
hl.bind(mainMod .. " + F3", exec(scripts .. "/no_terminal/scriptstart_interminal.sh"))
hl.bind(mainMod .. " + F5", exec(scripts .. "/themes/themepick.sh"))
hl.bind(mainMod .. " + F6", exec(scripts .. "/no_terminal/unicode_characters.sh"))
hl.bind(mainMod .. " + F7", exec(scripts .. "/no_terminal/passmenu.sh"))
hl.bind(mainMod .. " + SHIFT + F7", exec(scripts .. "/no_terminal/passmenu.sh --otp"))
hl.bind(mainMod .. " + F9", exec(scripts .. "/no_terminal/dictionary-english.sh"))
hl.bind(mainMod .. " + F10", exec(scripts .. "/no_terminal/godot_run.sh"))
hl.bind(mainMod .. " + SHIFT + F10", exec(scripts .. "/no_terminal/godot_stop.sh"))

-----------------------------------------------------------------------------
-- Window movement / organization
-----------------------------------------------------------------------------

hl.bind(mainMod .. " + Space", hy3_call("toggle_focus_layer")) -- Switch to floating window
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float()) -- Make window float
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(mainMod .. " + o", hy3_call("change_focus", "raise"))
hl.bind(mainMod .. " + i", hy3_call("change_focus", "lower"))
hl.bind(mainMod .. " + n", hy3_call("make_group", "h"))
hl.bind(mainMod .. " + m", hy3_call("make_group", "v"))
hl.bind(mainMod .. " + t", hy3_call("make_group", "tab", { ephemeral = "force" }))
hl.bind(mainMod .. " + y", hy3_call("change_group", "opposite"))
hl.bind(mainMod .. " + SHIFT + u", hy3_call("change_group", "tab"))
hl.bind(mainMod .. " + u", hy3_call("change_group", "untab"))

-- Setting window gaps
    -- Inner gaps
hl.bind(mainMod .. " + s"          , exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --inc_gaps_in"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + s"  , exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --dec_gaps_in"), { repeating = true })
    -- Outer gaps
hl.bind(mainMod .. " + z"          ,exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --inc_gaps_out"), { repeating = true })
hl.bind(mainMod .. " + SHIFT + z"  , exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --dec_gaps_out"), { repeating = true })
    -- Zero gaps
hl.bind(mainMod .. " + F11"        , exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --zero_gaps"),{ repeating = true })
    -- Reset gaps to default
hl.bind(mainMod .. " + SHIFT + F11", exec("sh " .. scripts .. "/themes/hypr_gap_setter.sh --reset_gaps"), { repeating = true })

-- Example special workspace (scratchpad)
--bind = $mainMod, x, togglespecialworkspace, magic
--bind = $mainMod SHIFT, x, movetoworkspace, special:magic

-- Scroll through existing workspaces.
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Focus: arrows.
hl.bind(mainMod .. " + down", hy3_call("move_focus", "d"))
hl.bind(mainMod .. " + up", hy3_call("move_focus", "u"))
hl.bind(mainMod .. " + left", hy3_call("move_focus", "l"))
hl.bind(mainMod .. " + right", hy3_call("move_focus", "r"))

-- Focus: vim keys.
hl.bind(mainMod .. " + j", hy3_call("move_focus", "d"))
hl.bind(mainMod .. " + k", hy3_call("move_focus", "u"))
hl.bind(mainMod .. " + h", hy3_call("move_focus", "l"))
hl.bind(mainMod .. " + l", hy3_call("move_focus", "r"))

-- Move windows: vim keys.
hl.bind(mainMod .. " + SHIFT + j", hy3_call("move_window", "d"))
hl.bind(mainMod .. " + SHIFT + k", hy3_call("move_window", "u"))
hl.bind(mainMod .. " + SHIFT + h", hy3_call("move_window", "l"))
hl.bind(mainMod .. " + SHIFT + l", hy3_call("move_window", "r"))

-- Move windows: arrows.
hl.bind(mainMod .. " + SHIFT + down", hy3_call("move_window", "d"))
hl.bind(mainMod .. " + SHIFT + up", hy3_call("move_window", "u"))
hl.bind(mainMod .. " + SHIFT + left", hy3_call("move_window", "l"))
hl.bind(mainMod .. " + SHIFT + right", hy3_call("move_window", "r"))

-----------------------------------------------------------------------------
-- Workspaces 1-10
-----------------------------------------------------------------------------

for i = 1, 10 do
    local key = ws_key(i)
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hy3_call("move_to_workspace", tostring(i)))
end

-----------------------------------------------------------------------------
-- Workspace set 2: 11-20
-----------------------------------------------------------------------------

hl.bind(mainMod .. " + grave", hl.dsp.submap("workspaceSet2"))

hl.define_submap("workspaceSet2", function()
    for i = 11, 20 do
        local key = ws_key(i)
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hy3_call("move_to_workspace", tostring(i)))
    end

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)

-----------------------------------------------------------------------------
-- Workspace set 3: 21-30
-----------------------------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.submap("workspaceSet3"))

hl.define_submap("workspaceSet3", function()
    for i = 21, 30 do
        local key = ws_key(i)
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hy3_call("move_to_workspace", tostring(i)))
    end

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)

-----------------------------------------------------------------------------
-- Resize submap (i3-like)
-----------------------------------------------------------------------------

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

    hl.bind("right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)

-----------------------------------------------------------------------------
-- Multimedia
-----------------------------------------------------------------------------

hl.bind("XF86AudioRaiseVolume",
exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
{ repeating = true, locked = true })

hl.bind("XF86AudioLowerVolume" ,exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),{ repeating = true, locked = true })
hl.bind("XF86AudioMute"        ,exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),{ repeating = true, locked = true })
hl.bind("XF86AudioMicMute"     ,exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),{ repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp"  ,exec("brightnessctl -e4 -n2 set 5%+"),{ repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown",exec("brightnessctl -e4 -n2 set 5%-"),{ repeating = true, locked = true })
hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })

-----------------------------------------------------------------------------
-- Window rules
-----------------------------------------------------------------------------

hl.window_rule({
    name = "ignore-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-dragging",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
    },
    pin = false,
    no_initial_focus = true,
    fullscreen_state = "0 0",
})

hl.window_rule({
    name = "zoom-stayfocused",
    match = {
        class = "^(zoom)$",
        title = "^(Zoom Workplace)$",
    },
    stay_focused = true,
})

-----------------------------------------------------------------------------
-- Workspace rules
-----------------------------------------------------------------------------

if hostname == "dirac" then
    hl.workspace_rule({ workspace = "1", monitor = monitor1 })
    hl.workspace_rule({ workspace = "2", monitor = monitor1 })
    hl.workspace_rule({ workspace = "3", monitor = monitor2 })
    hl.workspace_rule({ workspace = "12", monitor = monitor2 })
    hl.workspace_rule({ workspace = "8", monitor = monitor3 })
    hl.workspace_rule({ workspace = "9", monitor = monitor3 })
    hl.workspace_rule({ workspace = "10", monitor = monitor3 })
    hl.workspace_rule({ workspace = "11", monitor = monitor3 })
    hl.workspace_rule({ workspace = "20", monitor = monitor3 })
    hl.workspace_rule({ workspace = "21", monitor = monitor3 })
end

-----------------------------------------------------------------------------
-- Application workspace rules
-----------------------------------------------------------------------------

hl.window_rule({
    name = "spotify-workspace",
    match = { class = "^([Ss]potify)$" },
    workspace = "10",
})

hl.window_rule({
    name = "tidal-workspace",
    match = { class = "^([Tt]idal)$" },
    workspace = "10",
})

hl.window_rule({
    name = "discord-workspace",
    match = { class = "^([Dd]iscord)$" },
    workspace = "9",
})

hl.window_rule({
    name = "steam-workspace",
    match = { class = "^([Ss]team)$" },
    workspace = "7",
})

hl.window_rule({
    name = "steamwebhelper-workspace",
    match = { class = "^(steamwebhelper)$" },
    workspace = "7",
})

hl.window_rule({
    name = "pavucontrol-workspace",
    match = { class = "org.pulseaudio.pavucontrol" },
    workspace = "11",
})

hl.window_rule({
    name = "origin-float-1",
    match = { title = "origin.exe" },
    float = true,
})

hl.window_rule({
    name = "origin-float-2",
    match = { title = "OriginThinSetup.exe" },
    float = true,
})

hl.window_rule({
    name = "origin-float-3",
    match = { title = "^(\\*[Oo]rigin\\*)$" },
    float = true,
})

-----------------------------------------------------------------------------
-- Autostart
-----------------------------------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("sleep 3 && " .. scripts .. "/no_terminal/keyboard.sh")
    hl.exec_cmd("sleep 3 && " .. scripts .. "/no_terminal/hyprland_startup.sh")
    hl.exec_cmd(
        "sleep 20 && xrdb "
        .. home
        .. "/.Xresources && sleep 5 && "
        .. scripts
        .. "/themes/i3_theme_slideshow.sh"
    )
    hl.exec_cmd("sleep 10 && " .. scripts .. "/themes/i3_theme_slideshow.sh")
end)

