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

- "Close previous rice" with `~/lsrl-loaded/stop.sh`
- Symlink newly selected rice set folder to `~/lsrl-loaded` for easier access
- Execute `./lsrl-loaded/start.sh`
- Apply GTK and icon theme specified by the rice set
- Write the name of applied rice set to `./current.txt`

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