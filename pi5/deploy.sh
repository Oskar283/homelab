!/bin/bash

# Ensure this script is being run from the root of your git repository
REPO_ROOT=$(git rev-parse --show-toplevel)

# Path to the NFS mount (you will replace this with your actual mount point)
MOUNT_FOLDER="/mnt/homeassistant_config_and_data"  # Relative path to the mount config

# Exit if we're not in a git repo
if [ ! -d "$REPO_ROOT/.git" ]; then
    echo "Error: This script must be run from the root of a git repository."
    exit 1
fi

# Ensure the folder exists
if [ ! -d "$MOUNT_FOLDER" ]; then
    echo "Error: '$MOUNT_FOLDER' folder not found"
    exit 1
fi

# Get the list of files to deploy inside 'homeassistant_config' folder (files tracked by git but not ignored)
FILES_TO_DEPLOY=$(git ls-files --exclude-standard | grep "^homeassistant_config/")

# Ensure the destination folder exists
mkdir -p "$MOUNT_FOLDER"

# Loop through each file and copy it to the mount config destination
for FILE in $FILES_TO_DEPLOY; do
    # Remove the 'homeassistant_config/' prefix from the file path
    RELATIVE_PATH=${FILE#homeassistant_config/}

    # Get the destination path within the mount config
    DEST_FILE="$MOUNT_FOLDER/$RELATIVE_PATH"

    # Create the necessary directory structure in the mount config
    mkdir -p "$(dirname "$DEST_FILE")"

    # Copy the file to the destination
    cp "$FILE" "$DEST_FILE"

    echo "Deployed $FILE to $DEST_FILE"
done

echo "Deployment completed."

