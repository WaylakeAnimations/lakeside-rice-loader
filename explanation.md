### How `apply-general.sh` works

`./apply-general.sh [rice-set]`

- Make symlink of rice set folder in the home directory for easier access
- Execute rice set's `start.sh`
- Set GTK and icon theme specified by the rice set
- Make symlink of rice set's `stop.sh` in `./cache` for easier access when switching to another rice set
- Write the name of the applied rice set to `./current.txt`