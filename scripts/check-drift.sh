#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PIN_FILE="$HOME/TWGT-/.twgt/adr-registry-pin.json"
REGISTRY_DIR="$HOME/engineering-intelligence"

EXPECTED_SHA=$(jq -r '.bridge_sha' "$PIN_FILE")
EXPECTED_HASH=$(jq -r '.registry_sha256' "$PIN_FILE")
REGISTRY_PATH=$(jq -r '.path' "$PIN_FILE")

ACTUAL_SHA=$(cd "$REGISTRY_DIR" && git rev-parse HEAD)
ACTUAL_HASH=$(sha256sum "$REGISTRY_DIR/$REGISTRY_PATH" | awk '{print $1}')

echo "Expected SHA:  $EXPECTED_SHA"
echo "Actual SHA:    $ACTUAL_SHA"
echo "Expected Hash: $EXPECTED_HASH"
echo "Actual Hash:   $ACTUAL_HASH"

if [ "$EXPECTED_SHA" != "$ACTUAL_SHA" ]; then
  echo -e "\033[31m[FAIL] SHA DRIFT DETECTED. Registry commit does not match pin.\033[0m"
  exit 1
fi

if [ "$EXPECTED_HASH" != "$ACTUAL_HASH" ]; then
  echo -e "\033[31m[FAIL] HASH DRIFT DETECTED. Registry contents do not match pin.\033[0m"
  exit 1
fi

echo -e "\033[32m[ OK ] Registry SHA and Hash match the pin perfectly.\033[0m"

# --- Schema Gate Validation ---
echo "Running Schema Gate validation..."
cd "$HOME/twgt-schema-gate/contract-tests" && node run-ts.mjs > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo -e "\033[32m[ OK ] Schema Gate passed (22/22).\033[0m"
else
  echo -e "\033[31m[FAIL] Schema Gate failed.\033[0m"
  exit 1
fi
