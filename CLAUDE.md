# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a ZMK (Zephyr-based Mechanical Keyboard) firmware configuration for the Chocofi keyboard (36-key split) running a Miryoku-inspired layout with Colemak-DH base layer. The project uses the Corne shield for compatibility since both keyboards share the same 36-key layout.

## Key Commands

### Building Firmware
```bash
# Build left half
west build -s zmk/app -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG="./config"

# Build right half (use --pristine to clean build)
west build --pristine -s zmk/app -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG="./config"
```

### Initial Setup (if needed)
```bash
west init -l config
west update
west zephyr-export
```

## Architecture

### Configuration Structure
- **`corne.conf`**: Main keyboard configuration (Bluetooth, power, features)
- **`corne.keymap`**: 8-layer keymap definition with home row mods
- **`corne_left.conf`** / **`corne_right.conf`**: Split keyboard side configurations
- **`west.yml`**: Points to upstream ZMK repository

### Important Details
- Uses Corne shield with 5-column transform for Chocofi compatibility
- Both `chocofi.*` and `corne.*` files exist; use `corne.*` files for actual functionality
- Left half is configured as central (connects to computer)
- Right half is peripheral (connects to left half)
- GitHub Actions automatically builds firmware on push

### Layers
0. BASE - Colemak-DH with home row mods
1. SYM - Symbols
2. NUM - Numbers/numpad
3. NAV - Navigation
4. MEDIA - Media controls and Bluetooth profiles
5. MOUSE - Mouse emulation
6. FUN - Function keys
7. BUTTON - Additional mouse buttons

## Common Tasks

### Modifying Keymap
Edit `config/corne.keymap`. The file uses ZMK's keymap format with bindings for each layer.

### Changing Keyboard Settings
Edit `config/corne.conf` for features like Bluetooth power, sleep timeout, or combo settings.

### Testing Changes
Push to GitHub to trigger automated builds, or build locally using the commands above.