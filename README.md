# Joeplaa Conky

Based on Pomaria-Side Conky: <https://www.github.com/SZinedine/pomaria-side>

## Download and Launch

```sh
git clone https://www.github.com/joeplaa/joeplaa-conky
cd joeplaa-conky
conky -c conkyrc
```

- Edit `settings.lua` to choose your network interface, Internet speed and other settings.
- Edit `start.lua` to re-arrange.
- Edit `own_window_argb_value = 64` in `conkyrc` to change transparency.

## Launch on startup (Ubuntu)

Go to "Activities" or "Applications" and search for "Startup". Open the "Startup Applications Preferences" app.

Add a new program:

- Name: `Conky System Monitoring`
- Command: `<path to repository>/joeplaa-conky/start_conky.sh`
- Comment: leave blank or enter whatever you like

## Dependencies

- Conky 1.10+
- cairo
- imlib2
