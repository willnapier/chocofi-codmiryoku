# Bluetooth Persistence Configuration Update

## Date: January 2025

## Context
User reported Bluetooth connection persistence issues with their Chocofi keyboard - connections were not surviving across power cycles or sleep states.

## Changes Made

### 1. Updated `config/corne.conf`
Added minimal Bluetooth persistence settings:
```conf
# Enable bond persistence (saves pairing info across power cycles)
CONFIG_ZMK_SETTINGS_SAVE_DEBOUNCE=60000

# Set keyboard name for easier identification
CONFIG_ZMK_KEYBOARD_NAME="Chocofi"
```

### 2. Created `config/corne_left.conf`
```conf
# Left side is central (connects to computer)
CONFIG_ZMK_SPLIT_ROLE_CENTRAL=y

# Increase stack sizes for central role
CONFIG_SYSTEM_WORKQUEUE_STACK_SIZE=2048
CONFIG_MAIN_STACK_SIZE=2048
```

### 3. Created `config/corne_right.conf`
```conf
# Right side is peripheral (connects to left side)
```

## Rationale
- **Bond persistence**: The `CONFIG_ZMK_SETTINGS_SAVE_DEBOUNCE=60000` setting saves Bluetooth pairing information after 60 seconds of stable connection, which should help connections persist across power cycles
- **Split configuration**: Explicitly defining the left side as central ensures proper split keyboard roles
- **Conservative approach**: Avoided experimental BLE settings and aggressive buffer size changes to maintain stability

## Existing Bluetooth Controls
The keymap already has Bluetooth management keys in the media layer:
- `&bt BT_SEL 0-3` - Select bluetooth profiles 0-3
- `&bt BT_CLR` - Clear current bluetooth profile

## Status
- Changes committed as: `bb58a86`
- Pushed to GitHub
- User will flash firmware and test
- Awaiting feedback on whether persistence issues are resolved

### Update (January 2025)
- **Initial test successful**: User reports that after turning both keyboard halves off and back on, Bluetooth connection was successfully restored
- This is an encouraging start, though additional testing scenarios are still needed

## Potential Next Steps if Issues Persist
1. Add experimental BLE connection settings
2. Tune connection interval parameters
3. Increase Bluetooth buffer sizes
4. Debug with `CONFIG_ZMK_USB_LOGGING=y` (requires USB connection)

## Notes
- The keyboard is using Corne shield with 5-column (36-key) layout
- Previously resolved issues: matrix offset (6-col vs 5-col), M key hardware failure
- Mouse keys and Colemak-DH layout are working correctly