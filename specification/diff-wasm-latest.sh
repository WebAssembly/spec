#!/bin/bash

# Identify the highest versioned directory
HIGHEST_VER=$(ls -d wasm-[0-9]* 2>/dev/null | sort -V | tail -n 1)

if [ -z "$HIGHEST_VER" ]; then
    echo "❌ Error: No wasm-X.Y versioned directories found in specification/"
    exit 1
fi

LATEST="wasm-latest"

# Check that wasm-latest exists
if [ ! -d "$LATEST" ]; then
    echo "❌ Error: $LATEST does not exist."
    exit 1
fi

# Diff the highest version with wasm-latest and check that the diff is empty
echo "Checking for differences between $HIGHEST_VER and $LATEST..."

if diff -qr "$HIGHEST_VER" "$LATEST" > /dev/null; then
    echo "✅ Success: Contents match. No changes needed."
else
    echo "🔍 Differences detected:"
    echo "--------------------------------"
    diff -U0 -r "$HIGHEST_VER" "$LATEST"
    echo "--------------------------------"
    exit 1
fi
