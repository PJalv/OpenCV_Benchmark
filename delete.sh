#!/bin/bash

# Function to check and delete files in folders containing "Done" in their names

delete_done_folders() {
    emptied_folders=0
    echo "Folders containing 'Done':"
    while IFS= read -r -d '' folder; do
        echo "$folder"
    done < <(find . -type d -name "*Done*" -print0)

    # Ask for confirmation
    read -p "Proceed with deletion (y/n)? " answer
    case ${answer:0:1} in
        y|Y )
            while IFS= read -r -d '' folder; do
                if [ -n "$(find "$folder" -mindepth 1 -type f)" ]; then
                    echo "Deleting files in folder: $folder"
                    rm -r "$folder"/*
                    ((emptied_folders++))
                fi
            done < <(find . -type d -name "*Done*" -print0)
            echo "Emptied out $emptied_folders directories."
            ;;
        * )
            echo "Deletion aborted."
            ;;
    esac
}

# Main script
echo "Clearing output folders before run..."
delete_done_folders
echo "Deletion process completed."


