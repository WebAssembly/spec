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

# Sync the highest version with wasm-latest, depending on which is newer
echo "Synchronizing $HIGHEST with $LATEST..."

HIGHEST_FILES=$(cd $HIGHEST && ls *.spectec)
LATEST_FILES=$(cd $LATEST && ls *.spectec)

LATEST_CHANGED=0
HIGHEST_CHANGED=0

for FILE in $HIGHEST_FILES; do
    if [ ! -f "$LATEST/$FILE" ]; then
        echo "Added file $HIGHEST/$FILE"
        ((++HIGHEST_CHANGED))
    elif [ "$HIGHEST/$FILE" -nt "$LATEST/$FILE" ] && ! diff -q "$HIGHEST/$FILE" "$LATEST/$FILE" >/dev/null; then
        echo "Modified file $HIGHEST/$FILE"
        ((++HIGHEST_CHANGED))
    fi
done

for FILE in $LATEST_FILES; do
    if [ ! -f "$HIGHEST/$FILE" ]; then
        echo "Added file $LATEST/$FILE"
        ((++LATEST_CHANGED))
    elif [ "$LATEST/$FILE" -nt "$HIGHEST/$FILE" ] && ! diff -q "$HIGHEST/$FILE" "$LATEST/$FILE" >/dev/null; then
        echo "Modified file $LATEST/$FILE"
        ((++LATEST_CHANGED))
    fi
done

if [ $LATEST_CHANGED -gt 0 ] && [ $HIGHEST_CHANGED -gt 0 ]; then
    echo "❌ Error: Changes in both $HIGHEST and $LATEST."
    exit 1
fi

for FILE in $HIGHEST_FILES; do
    if [ ! -f "$LATEST/$FILE" ] || ([ "$HIGHEST/$FILE" -nt "$LATEST/$FILE" ] && ! diff -q "$HIGHEST/$FILE" "$LATEST/$FILE" >/dev/null); then
        cp "$HIGHEST/$FILE" "$LATEST/$FILE"
    fi
done

for FILE in $LATEST_FILES; do
    if [ ! -f "$HIGHEST/$FILE" ] || ([ "$LATEST/$FILE" -nt "$HIGHEST/$FILE" ] && ! diff -q "$HIGHEST/$FILE" "$LATEST/$FILE" >/dev/null); then
        cp "$LATEST/$FILE" "$HIGHEST/$FILE"
    fi
done
