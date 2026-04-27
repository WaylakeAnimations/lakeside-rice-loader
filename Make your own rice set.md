# Getting Started

- Initialize your project
```bash
./lsrl.sh --init your-rice
```
- Adjust the metadata (`rice.json`)
- Add your configs, i recommend starting with your bar and widget configs first
- Adjust the start and stop scripts

# Rice folder structure
```
- [dir] your-rice
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

### `.config`
Configs that are relevant for your rice...

### Files with `-lr` postfix
Rice-specific config glob (e.g. layer rules for widgets)...

### `wallpaper`
Rice-specific wallpapers...

### `rice.json`
Informations about the rice (like description and more)...

# Writing `rice.json`

There's not much to explain here other than the fact you can write "none" to the GTK and icon theme field if you don't want to override the current theme...

# Writing `start.sh`

The role of this script is starting things that are relevant for your rice (bars, widgets, and more)...

Since the selected rice folder is symlinked to `~/.lsrl-loaded`, you'll have to adjust arguments accordingly...

While you're at it, tell Hyprpaper to reload, of course after checking whether the process is there or not, if not, then start it...

```bash
# start if the process doesn't exist yet
if [ $(pgrep -c hyprpaper) -eq 0 ]; then
    hyprpaper --config ~/.config/hypr/hyprpaper.conf &
fi

# reload
hyprctl hyprpaper wallpaper ' , ~/.lsrl-loaded/wallpaper/static.png, fill' &
```

## Special scenario

Some stuff may require some care and attention, your options are...
- Change _everything_ that could start an app (e.g. `.desktop` entry, Hyprland hotkey, etc.) to include your config argument...
- Use `include` or any variants of it depending on the software...

### Using multiple configs

Many things can read multiple configs, therefore you can do the `*-lr.*` treatment for those...

You can do this manually, but in this case, we'll use `text-appender.sh` instead...

Keep ordering in mind, some softwares prioritize highest entry, while others prioritize lowest entry...

```bash
# format: text-appender.sh <flag> <text> <file>

# place at the bottom
bash $LSRL_PATH/text-appender.sh -b "include ~/.lsrl-loaded/.config/kitty/kitty-lr.conf" "~/.config/kitty/kitty.conf"

# place at the top
bash $LSRL_PATH/text-appender.sh -t "source = ~/.lsrl-loaded/.config/foo/foo-lr.conf" "~/.config/foo/foo.conf"
```

Most softwares won't complain about missing file in `include` entries if it has value(s) it can fall back to, so you don't have to worry about removing those in most cases...

### Not-so-divine intervention

If something doesn't support multiple configs and you can't feasibly change its launch arguments everywhere, you can temporarily symlink the configs...

Example snippet of `start.sh`
```bash
# Backup first!
mv ~/.config/john-terminal/config.ini ~/.config/john-terminal/config.ini-lrbak

# Symlink configs from lsrl-loaded
ln ~/.lsrl-loaded/.config/john-terminal/config.ini ~/.config/john-terminal/config.ini
```

Now you can run `john-terminal` with config from the rice set, but you'll need a way to restore it...

Example snippet of `stop.sh`
```bash
# Restore config to previous state
rm ~/.config/john-terminal/config.ini
mv ~/.config/john-terminal/config.ini-lrbak ~/.config/john-terminal/config.ini
```

You can do that with `.config` subdirectories instead of one file at a time, but make sure to adjust command flags accordingly...

# Writing `stop.sh`

The role of this script is stopping processes that were started by `start.sh` _except_ Hyprpaper...

Even if something in your rice set can reload on the fly, other rice sets _might not_ use it and the thing would just sit there _menacingly,_ so you should just stop it...

# Deviating

If you _really_ don't want Hyprpaper in your rice, add `pkill hyprpaper` to _the beginning_ of `start.sh`...

Yes, `start.sh`, not `stop.sh`...

`stop.sh` is executed when switching to another rice, while `start.sh` is executed when switching to **your** rice...
