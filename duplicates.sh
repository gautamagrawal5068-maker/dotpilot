#!/bin/bash

TARGET="$1"

if [ ! -d "$TARGET" ]; then
    echo "Error: Please provide a valid folder."
    exit 1
fi

echo "DOTPILOT DUPLICATE FINDER"
echo "--------------------------"

TEMP_FILE=$(mktemp)

while IFS= read -r -d '' file; do
if [ ! -s "$file" ]; then
    continue
fi

hash=$(shasum -a 256 "$file" | awk '{print $1}')

    existing=$(awk -v hash="$hash" '$1 == hash {sub($1 " ", ""); print; exit}' "$TEMP_FILE")

    if [ -n "$existing" ]; then
        echo ""
        echo "Duplicate found:"
        echo "  $existing"
        echo "  $file"
    else
        printf '%s %s\n' "$hash" "$file" >> "$TEMP_FILE"
    fi

done < <(find "$TARGET" -type f -print0)

rm -f "$TEMP_FILE"

echo ""
echo "Scan complete. No files were deleted."