# Getting Started

Arrange your rice set folder like this

```
- your-rice-set
  - [dir] .config
    - [dir] hypr
      - hyprland-lr.conf
  - [dir] wallpaper
    - static.png
    - live.mp4
  - rice.json
  - start.sh
  - stop.sh
```

Then add your configs, i recommend starting with your bar and widget configs first...

### `.config`
Contain configs and files that are relevant for your rice set...

### `hyprland-lr.conf`
Hyprland config glob, should only be used to change the visuals (e.g. adding layer rules for widgets)...

### `wallpaper`
Rice set-specific wallpapers...

### `rice.json`
Informations about the rice set like description, icon theme, and GTK theme _(yeah, that's all for now)..._

### `start.sh`
A script that "open the rice"...

### `stop.sh`
A script that "close the rice"...

# Writing `start.sh`

The role of this script is starting things that are relevant for your rice set...

Things like bars, widgets, even a terminal that automatically start a fetch command...

Since the selected rice set folder is symlinked to `~/lsrl-loaded`, you'll need to adjust arguments accordingly...

And while you're at it, tell Hyprpaper to reload because it couldn't do that by itself _(as of March 30th)..._

Of course after checking whether the process is there or not, if not, then start it...

## Special scenario

Some stuff may require some care and attention, let's use _Kitty_ for example, your options are...
- Change _everything_ that could start Kitty (.desktop entry, Hyprland hotkey, etc.) to include your config argument...
- Use `include`...

### Using multiple configs

Many things can read multiple configs, therefore you can do the `*-lr.*` treatment for those stuff...

Keep ordering in mind, some softwares prioritize highest entry, while others prioritize lowest entry...

```bash
# place at the bottom
bash $LSRL_PATH/text-appender.sh -b "include ~/lsrl-loaded/.config/kitty/kitty-lr.conf" "~/.config/kitty/kitty.conf"

# place at the top
bash $LSRL_PATH/text-appender.sh -t "source = ~/lsrl-loaded/.config/foo/foo-lr.conf" "~/.config/foo/foo.conf"
```

Most software won't complain about missing files in `include` entries if it has values in the main config file that it can fall back to, so you won't have to worry about removing it...

### Not-so-divine intervention

If something doesn't support multiple configs **AND** you can't feasibly change its launch arguments everywhere, but you _really_ want your rice set to affect it, you can temporarily symlink the configs...

Example snippet of `start.sh`

```bash
# Make sure to backup first!
mv ~/.config/john-terminal/bar.conf ~/.config/john-terminal/bar.conf1

# Symlink configs from lsrl-loaded
ln ~/lsrl-loaded/.config/john-terminal/bar.conf ~/.config/john-terminal/bar.conf
```

Now you can run `john-terminal` with config from the rice set, although you'll need a way to restore it to previous state...

Example snippet of `stop.sh`

```bash
# Restore config to previous state
rm ~/.config/john-terminal/bar.conf
mv ~/.config/john-terminal/bar.conf1 ~/.config/john-terminal/bar.conf
```

You can also do that with `.config` subdirectories instead of one file at a time, but make sure to adjust the command flags accordingly

# Writing `stop.sh`

The role of this script is stopping processes that were started by `start.sh` _except_ Hyprpaper...

Even if something in your rice set can reload on the fly, other rice sets _might not_ use it and the thing would just sit there _(menacingly),_ so you _should_ just stop it...

Be mindful with adding `pkill` entries though, for example, if you did add a terminal that automatically start a fetch command, find a way to _only_ close it or don't add `pkill` entry for that at all...

# Deviating

If you _really_ don't want Hyprpaper for your rice set, add `pkill hyprpaper` to _the beginning_ of `start.sh`...

Yes, `start.sh`, not `stop.sh`...

`stop.sh` is executed when switching _to another_ rice set, while `start.sh` is executed when switching _to_ **your** rice set...

If you want to use other WMs... well, _good luck..._ 🤞