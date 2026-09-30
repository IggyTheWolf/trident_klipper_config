<div align="center">

<img src="https://github.com/IggyTheWolf/trident_klipper_config/raw/gh-pages/wolf.svg" width="288" alt="IggyTheWolf logo">

# T R I D E N T

**トライデント整備記録 · Voron Trident 300 · Klipper config**

![Klipper](https://img.shields.io/badge/Klipper-v0.13.0-e5322b?style=flat-square&labelColor=07080c) ![Moonraker](https://img.shields.io/badge/Moonraker-v0.11.0-ffb347?style=flat-square&labelColor=07080c) ![Fluidd](https://img.shields.io/badge/Fluidd-v1.37.6-56d3cc?style=flat-square&labelColor=07080c) ![Octopus](https://img.shields.io/badge/Octopus-USB--CAN_bridge-b98c42?style=flat-square&labelColor=07080c) ![backup](https://img.shields.io/badge/backup-GIT_BACKUP-ff4fa3?style=flat-square&labelColor=07080c)

### [› open the build log](https://iggythewolf.github.io/trident_klipper_config/)

Every hardware, firmware, software and config change to this printer, newest first.

</div>

---

## › machine spec

| | |
|---|---|
| **frame** | Voron Trident, 300 mm build |
| **mainboard** | BTT Octopus V1.1 (STM32F446), flashed as a USB-to-CAN bridge |
| **can bus** | `can0`, 1 Mbit, Octopus RJ11 port (PD0/PD1) |
| **toolhead** | Stealthburner, Clockwork 2 extruder |
| **probe** | Voron Tap |
| **motion** | CoreXY, 0.9° A/B motors, TMC2209 |
| **z** | 3 × TR8x4 leadscrews, `Z_TILT_ADJUST` |
| **frontend** | Fluidd, crowsnest, Obico |

The full spec sheet and the non-stock parts list are on the [build log](https://iggythewolf.github.io/trident_klipper_config/).

## › what's in this repo

```
printer.cfg              frame: Octopus MCU, X/Y/Z, bed, probe, fans, z_tilt, bed_mesh, display
cw2.cfg                  extruder and hotend (Clockwork 2)
macros.cfg               PRINT_START / PRINT_END, purge, PA_CAL, PID_EXTRUDER / PID_BED, GIT_BACKUP
nozzle_scrub.cfg         CLEAN_NOZZLE brush wipe
stealthburner_leds.cfg   Stealthburner LED effects
adxl.cfg                 USB ADXL345, only included while it is plugged in
fluidd.cfg               link to the official fluidd-config (lives on the printer)
moonraker.conf           Moonraker, update manager
crowsnest.conf           webcam
```

`fluidd.cfg` and `moonraker_obico_macros.cfg` are links to files installed on the printer, so they don't open on GitHub.

## › how the backup works

- **`GIT_BACKUP`** (a macro in Fluidd) runs `.autocommit.sh`, which commits this folder and pushes it here.
- The printer pushes with an **SSH deploy key** that can only reach this repo. It never expires.
- The script **refuses to commit private files**: the Moonraker database (print history), `moonraker-obico.cfg` (Obico token), and Klipper's dated `printer-*.cfg` autosaves. `.gitignore` excludes them too.
- Full restore points and an SD card image are kept offline.

## › branches

| branch | contents |
|---|---|
| `main` | this config, pushed from the printer |
| `gh-pages` | the [build log](https://iggythewolf.github.io/trident_klipper_config/) site |

---

<div align="center"><sub>maintained by IggyTheWolf · edited with Claude Code</sub></div>
