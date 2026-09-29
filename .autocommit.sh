#!/bin/sh
# Backs up ~/printer_data/config to GitHub (deploy key in ~/.ssh/github_trident_backup).
# Run by the GIT_BACKUP macro. The Moonraker database lives outside this folder and is never committed.
config_folder=/home/pi/printer_data/config

ver() { [ -d "$1/.git" ] && git -C "$1" describe --tags --always 2>/dev/null; }
m1="Klipper: $(ver /home/pi/klipper)"
m2="Moonraker: $(ver /home/pi/moonraker)"
m3="Fluidd: $(head -n 1 /home/pi/fluidd/.version 2>/dev/null)"

cd "$config_folder" || exit 1
git pull --rebase --autostash -q || { echo "git pull failed"; exit 1; }
git add -A
# Safety net: refuse to push anything that looks like a database or the Obico token file
if git diff --cached --name-only | grep -Eiq "\.(db|mdb|sqlite3?)$|moonraker-obico\.cfg$"; then
  echo "Refusing to commit private files:"; git diff --cached --name-only | grep -Ei "\.(db|mdb|sqlite3?)$|moonraker-obico\.cfg$"
  git reset -q; exit 1
fi
if git diff --cached --quiet; then echo "No config changes to back up."; exit 0; fi
git commit -q -m "Autocommit from $(date +"%Y-%m-%d %T")" -m "$m1" -m "$m2" -m "$m3"
git push -q && echo "Config backed up to GitHub."
