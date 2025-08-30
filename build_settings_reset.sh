#!/bin/bash
# Build settings_reset firmware for Piantor Pro BT

echo "Building settings_reset for Piantor Pro BT..."

# Save current directory
CURRENT_DIR=$(pwd)

# Go to zmk app directory
cd ../zmk/app || exit 1

# Build left half
echo "Building left half..."
west build -b piantor_pro_bt_left -- -DSHIELD=settings_reset
cp build/zephyr/zmk.uf2 "$CURRENT_DIR/piantor_pro_bt_left_settings_reset.uf2"

# Build right half
echo "Building right half..."
west build --pristine -b piantor_pro_bt_right -- -DSHIELD=settings_reset
cp build/zephyr/zmk.uf2 "$CURRENT_DIR/piantor_pro_bt_right_settings_reset.uf2"

cd "$CURRENT_DIR"
echo "Done! Settings reset firmware files created:"
echo "  - piantor_pro_bt_left_settings_reset.uf2"
echo "  - piantor_pro_bt_right_settings_reset.uf2"