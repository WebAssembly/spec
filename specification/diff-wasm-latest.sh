#!/bin/bash

# Identify the highest versioned directory
HIGHEST=$(ls -d wasm-[0-9]* 2>/dev/null | sort -V | tail -n 1)

# Check that highest exists
if [ -z "$HIGHEST" ]; then
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
echo "Checking for differences between $HIGHEST and $LATEST..."

if diff -qr "$HIGHEST" "$LATEST" > /dev/null; then
    echo "✅ Success: Contents match. No changes needed."
else
    echo "🔍 Differences detected:"
    echo "--------------------------------"
    diff -U0 -r "$HIGHEST" "$LATEST"
    echo "--------------------------------"
    exit 1
fi
