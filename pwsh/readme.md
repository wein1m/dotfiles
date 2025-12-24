```
⠀⠀⠀⠀⣠⣶⡾⠏⠉⠙⠳⢦⡀⠀⠀⠀⢠⠞⠉⠙⠲⡀⠀
⠀⠀⠀⣴⠿⠏⠀⠀⠀⠀⠀⠀⢳⡀⠀⡏⠀⠀⠀⠀⠀⢷
⠀⠀⢠⣟⣋⡀⢀⣀⣀⡀⠀⣀⡀⣧⠀⢸⠀⠀⠀⠀⠀ ⡇
⠀⠀⢸⣯⡭⠁⠸⣛⣟⠆⡴⣻⡲⣿⠀⣸⠀⠀Hi⠀ ⡇
⠀⠀⣟⣿⡭⠀⠀⠀⠀⠀⢱⠀⠀⣿⠀⢹⠀⠀⠀⠀⠀ ⡇
⠀⠀⠙⢿⣯⠄⠀⠀⠀⢀⡀⠀⠀⡿⠀⠀⡇⠀⠀⠀⠀⡼
⠀⠀⠀⠀⠹⣶⠆⠀⠀⠀⠀⠀⡴⠃⠀⠀⠘⠤⣄⣠⠞⠀
⠀⠀⠀⠀⠀⢸⣷⡦⢤⡤⢤⣞⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣤⣴⣿⣏⠁⠀⠀⠸⣏⢯⣷⣖⣦⡀⠀⠀⠀⠀⠀⠀
⢀⣾⣽⣿⣿⣿⣿⠛⢲⣶⣾⢉⡷⣿⣿⠵⣿⠀⠀⠀⠀⠀⠀
⣼⣿⠍⠉⣿⡭⠉⠙⢺⣇⣼⡏⠀⠀⠀⣄⢸⠀⠀⠀⠀⠀⠀
⣿⣿⣧⣀⣿.........⣀⣰⣏⣘⣆⣀⠀⠀
```
# 🐰 My PowerShell Profile

This folder contains **my PowerShell (`pwsh`) profile**.
It mainly consists of functions and alises to make my work environment enjoyable and fun.


## ⚠️ Notes Before Using

* Many paths are **hard‑coded** for my machine
* Windows + PowerShell 7+ is assumed
* You’re encouraged to copy **parts**, not the whole profile. (but if you want, go for it lol~)



## Functions & Aliases

Below is a categorized overview of **everything** defined in my `profile.ps1`.

### File & Directory Management

* `touch` — unix‑like way to create one or more empty files
* `mkdird` — create a directory and immediately `cd` into it
* `cdd` — `cd` into a directory and automatically run `ls`
* `rmdirs` — remove directories recursively (`rm -r -fo` wrapper)
* `get-size` — show human‑readable directory size (`KiB`, `MiB`, `GiB`)
* `gpath` — copy current working directory to clipboard
- `whereis` - locate the executable file's path 

---

### Search & Web Helpers

I use brave for my browser, so if you use other (Chrome, Firefox, etc), remember to change it with yours.
also, don't forget to put the executable path to the PATH env or put it into variable.

* `search` — Brave search with free‑form queries
* `why` — search prefixed with “why …”
* `howtf` — search prefixed with “how tf …”
* `wtf` — search prefixed with “wtf …”
* `translate` — open Google Translate (EN↔ID), supports `-r` for reverse mode (ID↔EN)
* `open` — open URL using Brave

---

### Development & Editor Workflow

* `vscFocus` — switch VS Code settings between *focus* and *normal* modes
* `remove-vscLogo` — patch VS Code CSS to remove the logo at top left corner
* `clangd` — generate `.clangd` config from predefined presets
* `pwsh-big` — open Windows Terminal centered with large size (i usually use 80x17)
* `komom` — start komorebi & yasb, support `-stop` or `-n` to stop them

---

### System & Network Utilities

* `killall` — terminate user processes with grouping and confirmation (`-a` for all)
* `Get-FileMetaData` — extract extended file metadata using Windows Shell
* `shutdowns` — shutdown the system immediately
* `restart` — restart the system immediately
* `connect-home` — connect to predefined Wi‑Fi network
* `connect-phone` — connect to phone hotspot

---

### External Tool Wrappers

* `spotify` — run `spicetify auto` with lovely feedback🐰
* `download` — run custom Python TikTok downloader
* `compress` — run custom Python file compression script
* `mai` — ask questions to a local LLM (Ollama), supports `-s` simple mode
* `maii` — shorthand for `ollama run mai`

---

### Others (?)

* `get-func` — print the source of my defined function
* `hr` — draw horizontal rules relative to terminal width
* `clearl` — clear screen and run `fastfetch`
* `clearo` — reload the PowerShell profile
* `ompSimple` — switch to a minimal Oh‑My‑Posh theme
  
---

### Aliases

Aliases are used **only** for single‑command shortcuts.
Anything involving arguments or logic becomes a function.

* `vim` → `nvim`
* `rename` → `rename-item`
* `grep` → `select-string`
* `nano` → `micro`
* `rar` → `WinRAR.exe`
* `gpp` → `g++`
* `wth` → `wtf`
