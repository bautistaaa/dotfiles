-- Globals shared across all modules
MAIN_MOD     = "SUPER"
TERMINAL     = "kitty"
BROWSER      = "~/.config/hypr/scripts/chrome.sh"
FILE_MANAGER = "~/.config/hypr/scripts/yazi.sh"
MENU         = "rofi -show drun -modes drun,run -theme ~/.config/rofi/config.rasi"
WINDOW_MENU  = "~/.config/rofi/scripts/rofi-window.sh"
CALC_MENU    = "~/.config/rofi/scripts/rofi-calc.sh"

require("modules.autostart")
require("modules.input")
require("modules.appearance")
require("modules.keybinds")
