## About `lsrl.sh`

This is the script you'll (in)directly interact with to switch between rice sets...

```
./lsrl.sh [rice-set]
```

### How it works _(in order):_

- "Close previous rice" with `~/lsrl-loaded/stop.sh`
- Symlink newly selected rice set folder to `~/lsrl-loaded` for easier access
- Execute `./lsrl-loaded/start.sh`
- Apply GTK and icon theme specified by the rice set
- Write the name of applied rice set to `./current.txt`