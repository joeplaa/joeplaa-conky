# Joeplaa Conky

Based on Pomaria-Side Conky: <https://www.github.com/SZinedine/pomaria-side>

## Hardware specs

- PC: Lenovo P520
- CPU: Intel Xeon W-2135 (6-core, 12 threads)
- GPU1: Nvidia Quadro P1000
- SSD: Samsung NVMe PCIe gen 3x4
- Nic: 10 Gbit (configured as bridge for qemu and vlan for san)

## Download and Launch

```sh
git clone https://www.github.com/joeplaa/joeplaa-conky
cd joeplaa-conky

conky -c conkyrc
# or
./start_conky.sh
```

## Edit / customize

- Edit `settings.lua` to choose your network interface, internet speed and other settings.
- Edit `start.lua` to re-arrange.
- Edit `own_window_argb_value = 64` in `conkyrc` to change transparency.

## Launch on startup (Ubuntu)

Go to "Activities" or "Applications" and search for "Startup". Open the "Startup Applications Preferences" app.

Add a new program:

- Name: `Conky PC`
- Command: `<path to repository>/joeplaa-conky/start_conky.sh`
- Comment: leave blank or enter whatever you like

Or use `systemd`:

- Edit: `conky.service`; edit path to `start_conky.sh` and set display number, find with `echo $DISPLAY`
- Create: `~/.config/systemd/user/conky.service` and copy content
- Enable: `systemctl enable conky.service`
- Start: `systemctl start conky.service`

## Dependencies

- Conky 1.10+
- cairo
- imlib2
