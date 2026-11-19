----------------------
---- SCREENSHOTS ----
----------------------

local screenshotBindings = {
    -- Normal screenshots.
    { key = "Print", command = "~/.config/satty/scripts/shot_display.sh" },
    { key = "SUPER + Print", command = "~/.config/satty/scripts/shot_window.sh" },
    { key = "SHIFT + Print", command = "~/.config/satty/scripts/shot_region.sh" },

    -- Clipboard screenshots.
    { key = "CTRL + Print", command = "~/.config/satty/scripts/shot_display_clipboard.sh" },
    { key = "CTRL + SUPER + Print", command = "~/.config/satty/scripts/shot_window_clipboard.sh" },
    { key = "CTRL + SHIFT + Print", command = "~/.config/satty/scripts/shot_region_clipboard.sh" },
}

for _, binding in ipairs(screenshotBindings) do
    hl.bind(binding.key, hl.dsp.exec_cmd(binding.command))
end
