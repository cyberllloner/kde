#!/bin/bash

# Define the URL and the target directory
URL="https://github.com/rose-pine/gtk/releases/download/v2.0.0/AllRosePineThemesIcons.tar.gz"
TARGET_DIR="$HOME/.local/share/icons"
TAR_FILE="AllRosePineThemesIcons.tar.gz"
EXTRACT_DIR="AllRosePineThemesIcons"

# Check if the icons directory exists
if [ ! -d "$TARGET_DIR" ]; then
    # Create the icons directory if it doesn't exist
    mkdir -p "$TARGET_DIR"
    echo "Created icons directory at '$TARGET_DIR'."
else
    echo "Icons directory already exists at '$TARGET_DIR'. Skipping creation."
fi

# Check if the tar.gz file has already been downloaded
if [ -f "$TAR_FILE" ]; then
    echo "The icon pack has already been downloaded. Skipping download."
else
    # Download the tar.gz file using wget
    echo "Downloading the icon pack..."
    if wget -O "$TAR_FILE" "$URL"; then
        echo "Download completed successfully."
    else
        echo "Failed to download the icon pack."
        exit 1
    fi
fi

# Extract the tar.gz file
echo "Decompressing the icon pack..."
if tar xf "$TAR_FILE" -C ./; then
    echo "Decompression completed successfully."
else
    echo "Decompression failed. The tar file may be corrupted."
    exit 1
fi

# Inform the user about the available variants
echo "Available variants:"
ls "$EXTRACT_DIR"

# Prompt user to specify the variant they want to use
echo "Please enter the variant name you want to use (e.g., rose-pine-icons, rose-pine-dawn-icons, rose-pine-moon-icons):"
read VARIANT_NAME

# Check if the specified variant directory exists
if [ -d "$EXTRACT_DIR/$VARIANT_NAME" ]; then
    # Copy the variant folder to the icons directory
    cp -r "$EXTRACT_DIR/$VARIANT_NAME" "$TARGET_DIR/"
    echo "Copied '$VARIANT_NAME' to '$TARGET_DIR'."
else
    echo "The specified variant '$VARIANT_NAME' does not exist."
    exit 1
fi

# Clean up by removing the extracted folder
rm -rf "$EXTRACT_DIR"

# Final instructions
echo "Now, please go to System Settings > Appearance > Icons to apply the new icon pack."
echo "Installation complete!"

