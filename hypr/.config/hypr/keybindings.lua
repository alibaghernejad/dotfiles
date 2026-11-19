---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local terminal = "alacritty"
local fileManager = "nautilus"
local menu = "walker"

-- Applications and common window actions.
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

-- Switch between the Dwindle and Master layouts.
hl.bind(mainMod .. " + CTRL + D", function()
    hl.config({ general = { layout = "dwindle" } })
end)
hl.bind(mainMod .. " + CTRL + M", function()
    hl.config({ general = { layout = "master" } })
end)

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

-- Move focus with mainMod + arrow keys or vim keys.
local directions = {
    { key = "LEFT",  direction = "left" },
    { key = "RIGHT", direction = "right" },
    { key = "UP",    direction = "up" },
    { key = "DOWN",  direction = "down" },
    { key = "H",     direction = "left" },
    { key = "L",     direction = "right" },
    { key = "K",     direction = "up" },
    { key = "J",     direction = "down" },
}

for _, direction in ipairs(directions) do
    hl.bind(mainMod .. " + " .. direction.key, hl.dsp.focus({ direction = direction.direction }))
end

-- Move windows with mainMod + SHIFT + arrow keys or vim keys.
for _, direction in ipairs(directions) do
    hl.bind(mainMod .. " + SHIFT + " .. direction.key,
        hl.dsp.window.move({ direction = direction.direction }))
end

-- Switch workspaces with mainMod + [0-9] and move windows with SHIFT.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move and resize windows with mainMod + left/right mouse buttons.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------
---- MEDIA CONTROLS ----
-------------------------

-- Volume and brightness controls work while locked and repeat when held.
for _, binding in ipairs({
    { key = "XF86AudioRaiseVolume", command = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" },
    { key = "XF86AudioLowerVolume", command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" },
    { key = "XF86AudioMute", command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" },
    { key = "XF86AudioMicMute", command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" },
    { key = "XF86MonBrightnessUp", command = "brightnessctl s 10%+" },
    { key = "XF86MonBrightnessDown", command = "brightnessctl s 10%-" },
}) do
    hl.bind(binding.key, hl.dsp.exec_cmd(binding.command), { locked = true, repeating = true })
end

-- Media playback keys require playerctl.
for _, binding in ipairs({
    { key = "XF86AudioNext", command = "playerctl next" },
    { key = "XF86AudioPause", command = "playerctl play-pause" },
    { key = "XF86AudioPlay", command = "playerctl play-pause" },
    { key = "XF86AudioPrev", command = "playerctl previous" },
}) do
    hl.bind(binding.key, hl.dsp.exec_cmd(binding.command), { locked = true })
end

-----------------------
---- FULLSCREEN ------
-----------------------

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
