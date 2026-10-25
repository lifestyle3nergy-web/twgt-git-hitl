#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PIN_FILE="$HOME/TWGT-/.twgt/adr-registry-pin.json"
EXPECTED_BRIDGE_SHA=$(jq -r '.bridge_sha' "$PIN_FILE")
ACTUAL_BRIDGE_SHA=$(cd "$HOME/twgt-bridge" && git rev-parse HEAD)

echo "Expected Bridge SHA: $EXPECTED_BRIDGE_SHA"
echo "Actual Bridge SHA:   $ACTUAL_BRIDGE_SHA"

if [ "$EXPECTED_BRIDGE_SHA" != "$ACTUAL_BRIDGE_SHA" ]; then
  echo -e "\033[31m[FAIL] SHA DRIFT DETECTED. HITL cannot admit this state.\033[0m"
  echo "Action: Update the pin file or checkout the correct bridge commit."
  exit 1
else
  echo -e "\033[32m[ OK ] Bridge SHA matches the pin.\033[0m"
fi
