import os
from urllib.request import urlopen

config.load_autoconfig()

c.fonts.default_family = "SpaceMono Nerd Font"
c.fonts.default_size = "12pt"
c.colors.webpage.preferred_color_scheme = "dark"

# tabs
c.tabs.show = "switching"
c.tabs.title.alignment = "center"
c.tabs.show_switching_delay = 1500
c.tabs.position = "bottom"

# statusbar
c.statusbar.position = "top"
c.statusbar.widgets = [
        "url",
        "tabs",
        "progress"
        ]
c.statusbar.show = "in-mode"

# keybinds
config.bind(',b', 'spawn brave --new-window {url}') # if things dont work out, just open brave :)

## rebind, makes more sense for me this way
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')

# load color-scheme
if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'frappe', True)
