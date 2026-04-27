## About `lsrl.sh`

This is the script you'll (in)directly interact with to switch between rice sets and do other stuff...

Recommended usage:

```
  ./lsrl.sh [rice-set-folder-name]
  ./lsrl.sh [flag]
```

Flags:

```
  -h, --help         Display informations about this script
  -r, --relaunch     (Re)launch last rice set (reads from ./current.txt)
  -i, --init <name>  Initialize a new rice set project
```

### How it works _(in order):_

- "Close previous rice" with `~/.lsrl-loaded/stop.sh`
- Symlink newly selected rice set folder to `~/.lsrl-loaded` for easier access
- Execute `./lsrl-loaded/start.sh`
- Apply GTK and icon theme specified by the rice set
- Write the name of applied rice set to `./current.txt`

## About `project-init.sh`

The script executed by `lsrl.sh` when the `--init` flag is specified, the reason it's a separate thing is to keep `lsrl.sh` tidy, i don't recommend running it directly...

### How it works _(in order):_

- Check if it's executed by `lsrl.sh`, continue if it does
- Generate basic rice set project you can use as a starting point

## About `text-appender.sh`

Use this to add `include` entries (or any variants of that) to config files...

Recommended usage:

```
  appender.sh [flag] <text> <file>
```

Flags:

```
  -h, --help   show this
  -t  place    <text> on the top of <file> (prepend)
  -b  place    <text> on the bottom of <file> (append)
```

### How it works _(in order):_

- Handle `~` in `<file>` argument by replacing it with your actual home directory
- Check if `<text>` already exist inside `<file>`, continue if it doesn't
- Add `<text>` into `<file>`, either on top or bottom
