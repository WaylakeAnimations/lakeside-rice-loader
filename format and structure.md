## Supported stuff

While you _can_ make this work with many things, in terms of WM and Wallpaper, this only _officially_ support Hyprland and Hyprpaper respectively...

For other things like bars and widgets, you can pick whatever you want...

## Rice set structure

```
- your-theme
  - [dir] .config
    - [dir] hypr
      - lsrl-rice-specific.conf
  - [dir] wallpaper
    - static.png
    - live.mp4
  - rice.json
  - start.sh
  - stop.sh
```

### `.config`
Contain configs and files that are relevant for your rice set...

### `lslr-rice-specific.conf`
Hyprland config glob, should only be used to change the visuals (e.g. adding layer rules for widgets)...

### `wallpaper`
Rice set-specific wallpapers...

### `rice.json`
Informations about the rice set like description, icon theme, and GTK theme _(yeah, that's all for now)..._

### `start.sh`
A script that "open the rice"...

### `stop.sh`
A script that "close the rice"...

## Writing `start.sh`

The role of this script is starting things that are relevant for your rice set...

Things like bars, widgets, even a terminal that automatically start a fetch command...

And while you're at it, tell Hyprpaper to reload because it couldn't do that by itself _(as of March 30th)..._

Of course after checking whether the process is there or not, if not, then start it...

## Writing `stop.sh`

The role of this script is stopping processes that were started by `start.sh` _except_ Hyprpaper...

Even if something in your rice set can reload on the fly, other rice sets _might not_ use it and the thing would just sit there _(menacingly),_ so you _should_ just stop it...

Be mindful with adding `pkill` entries though, for example, if you did add a terminal that automatically start a fetch command, find a way to _only_ close it or don't add `pkill` entry for that at all...

## Deviating

If you _really_ don't want Hyprpaper for your rice set, add `pkill hyprpaper` to _the beginning_ of `start.sh`...

Yes, `start.sh`, not `stop.sh`...

`stop.sh` is executed when switching _to another_ rice set, while `start.sh` is executed when switching _to_ **your** rice set...

If you want to use other WMs... well, _good luck..._ 🤞