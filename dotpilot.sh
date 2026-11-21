
#!/bin/bash

VERSION="1.0.0"

show_banner() {
    echo ""
    echo "DOTPILOT v$VERSION"
    echo "Your terminal productivity toolkit"
    echo ""
}

inspect_project() {
    echo "PROJECT INSPECTOR"
    echo "-----------------"
    echo "Location: $(pwd)"
    echo "Files: $(find . -type f -not -path './.git/*' | wc -l | tr -d ' ')"
    echo "Folders: $(find . -type d -not -path './.git/*' | wc -l | tr -d ' ')"
    echo ""
    echo "Directory contents:"
    ls -lah
}

show_help() {
    echo "Usage: ./dotpilot.sh [command]"
    echo ""
    echo "Commands:"
    echo "  help        Show available commands"
    echo "  inspect     Inspect current directory"
    echo "  version     Show version"
    echo "  organise    Organise files in a folder"
    echo "  duplicates  Find duplicate files"
}

get_category() {
    case "$1" in
        jpg|jpeg|png|gif|webp) echo "Images" ;;
        pdf|doc|docx|txt|ppt|pptx|xls|xlsx) echo "Documents" ;;
        mp4|mov|mkv|avi) echo "Videos" ;;
        mp3|wav|m4a|aac) echo "Audio" ;;
        py|sh|js|ts|html|css|json|c|cpp) echo "Code" ;;
        zip|tar|gz|rar|7z) echo "Archives" ;;
        *) echo "Others" ;;
    esac
}

organise_files() {
    TARGET="$2"

    if [ -z "$TARGET" ]; then
        echo "Please specify a folder."
        echo "Example: ./dotpilot.sh organise test-files"
        return 1
    fi

    if [ ! -d "$TARGET" ]; then
        echo "Error: Folder not found: $TARGET"
        return 1
    fi

    echo "DOTPILOT FILE ORGANISER"
    echo "------------------------"
    echo "Target: $TARGET"
    echo ""
    echo "Preview of proposed file moves:"

    for file in "$TARGET"/*; do
        [ -f "$file" ] || continue

        name=$(basename "$file")
        ext="${name##*.}"
        ext=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')
        category=$(get_category "$ext")

        echo "$name -> $category/"
    done

    echo ""
    read -r -p "Move these files? (y/N): " answer

    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
        echo "Cancelled. No files were moved."
        return 0
    fi

    for file in "$TARGET"/*; do
        [ -f "$file" ] || continue

        name=$(basename "$file")
        ext="${name##*.}"
        ext=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')
        category=$(get_category "$ext")

        mkdir -p "$TARGET/$category"
        destination="$TARGET/$category/$name"

        if [ -e "$destination" ]; then
            echo "Skipped (already exists): $name"
            continue
        fi

        mv "$file" "$destination"
        echo "Moved: $name -> $category/"
    done

    echo ""
    echo "Organisation complete!"
}

find_duplicates() {
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    DUPLICATE_SCRIPT="$SCRIPT_DIR/duplicates.sh"

    if [ ! -f "$DUPLICATE_SCRIPT" ]; then
        echo "Error: duplicates.sh not found."
        return 1
    fi

    bash "$DUPLICATE_SCRIPT" "$2"
}

show_banner

case "$1" in
    help)
        show_help
        ;;
    inspect)
        inspect_project
        ;;
    version)
        echo "DotPilot v$VERSION"
        ;;
    organise)
        organise_files "$@"
        ;;
    duplicates)
        find_duplicates "$@"
        ;;
    *)
        show_help
        ;;
esac
