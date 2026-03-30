# Lakeside Rice Loader
Scripts that allows you to easily switch between rice sets on the fly...

## Installation
- Open your terminal
- Navigate to `~/.local/share/`
- Clone this repo
- (Optional) turn your current rice into a rice set (read the [tutorial](https://github.com/WaylakeAnimations/lakeside-rice-loader/blob/main/Making%20your%20own%20rice%20set.md))...

You don't have to include your entire `.config` folder, just include the relevant configs (bar, widgets, etc.)...

- Adjust your autostart (don't forget to remove duplicates in the `hyprland.conf` side)...
```
exec-once = bash ~/.local/share/lakeside-rice-loader/lsrl.sh [rice-name]
```
If you want it to remember the rice set that was selected, replace `[rice-name]` with this...
```bash
$(cat ~/.local/share/lakeside-rice-loader/current.txt)
```
_todo:_
- _make launching last rice set built-in (perhaps with -r flag)_
- _use axolotl as fallback when no rice set name entered_
- _add --help and -h_

## Fun Fact
This entire thing was started when i needed a quick way to make my Hyprland rice look family-friendly...

Specifically, a time when i was studying in school (i wanted to make Hanako-themed rice at the time)...
