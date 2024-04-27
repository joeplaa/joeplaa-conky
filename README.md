# Joeplaa Conky

Based on Pomaria-Side Conky: <https://www.github.com/SZinedine/pomaria-side>

## Download and Launch

```sh
git clone https://www.github.com/joeplaa/joeplaa-conky
cd joeplaa-conky
conky -c conkyrc_pc
conky -c conkyrc_server
```

## Edit / customize

- Edit `settings.lua` to choose your network interface, Internet speed and other settings.
- Create `env.lua` and add server credentials and data

    ```lua
    serverlabel1 = "S2"
    hostname1 = "..."
    host_ip1 = "..."
    ipmi_ip1 = "..."
    ipmi_user1 = "..."
    ipmi_pass1 = "..."

    serverlabel2 = "..."
    hostname2 = "..."
    host_ip2 = "..."
    ipmi_ip2 = "..."
    ipmi_user2 = "..."
    ipmi_pass2 = "..."

    serverlabel3 = "..."
    hostname3 = "..."
    host_ip3 = "..."
    ipmi_ip3 = "..."
    ipmi_user3 = "..."
    ipmi_pass3 = "..."

    serverlabel4 = "..."
    hostname4 = "..."
    host_ip4 = "..."
    ipmi_ip4 = "..."
    ipmi_user4 = "..."
    ipmi_pass4 = "..."
    ```

- Edit `start.lua` to re-arrange.
- Edit `own_window_argb_value = 64` in `conkyrc` to change transparency.

## Launch on startup (Ubuntu)

Go to "Activities" or "Applications" and search for "Startup". Open the "Startup Applications Preferences" app.

Add a new program:

- Name: `Conky System Monitoring`
- Command: `<path to repository>/joeplaa-conky/start_conky_pc.sh`
- Comment: leave blank or enter whatever you like

Add a new program:

- Name: `Conky System Monitoring`
- Command: `<path to repository>/joeplaa-conky/start_conky_server.sh`
- Comment: leave blank or enter whatever you like

## Dependencies

- Conky 1.10+
- cairo
- imlib2
