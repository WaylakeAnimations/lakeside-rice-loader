### `apply.sh` (theme specific)
- Run `./apply-general.sh`
- Run `./cache/pkiller.sh`
- Tell softwares that can reload on the fly to reload _(notable mention: hyprpaper)_
- Restart softwares that were stopped earlier
- Copy `pkiller.sh` in the theme folder to `./cache`

### `apply-general.sh`
- Set GTK and icon theme specified by the theme
- Swap configs with the ones from the theme
- Make a symlink to the theme's wallpaper folder

### `pkiller.sh` (theme specific)
- Stop softwares that can't reload configs on the fly _(notable mention: waybar)_

The one that will be executed is the one inside `./cache`

It's a separate script in case a rice has different set of softwares to run (and stop when switching from that to another)

In simple terms, `apply.sh` and `apply.general.sh` _"open a rice",_ while `pkiller.sh` _"close the current rice",_ all without restarting the WM
