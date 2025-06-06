#!/bin/bash

# Clone the repository
REPO_URL="https://github.com/kelpwave/Rose-pine-for-KDE.git"
CLONE_DIR="Rose-pine-for-KDE"
COLOR_SCHEME_DIR="$HOME/.local/share/color-schemes"

# Check if the repository has already been cloned
if [ -d "$CLONE_DIR" ]; then
    echo "The repository '$CLONE_DIR' already exists. Please remove it or use the existing files."
    exit 1
fi

# Clone the repository
git clone "$REPO_URL"

# Navigate to the cloned directory
cd "$CLONE_DIR" || { echo "Failed to enter directory"; exit 1; }

# Inform the user about the next steps
echo "Please go to System Settings > Appearance > Plasma Style and select 'Install from File...'."
echo "From the cloned directory, select the subdirectory of the variant you like most."
echo "Select the tar.gz file of the chosen variant."
echo "After that, press any key to continue..."
read -n 1 -s -r

# Create the color schemes directory if it doesn't exist
mkdir -p "$COLOR_SCHEME_DIR"

# Define the color scheme file for the Moon variant
COLOR_SCHEME_FILE="$COLOR_SCHEME_DIR/RosePineMoon.colors"

# Check if the color scheme file already exists
if [ -f "$COLOR_SCHEME_FILE" ]; then
    echo "The color scheme file 'RosePineMoon.colors' already exists in '$COLOR_SCHEME_DIR'."
    echo "Please remove it or choose a different variant."
    exit 1
fi

# Move the color scheme file
if [ -f "colorschemes/RosePineMoon.colors" ]; then
    mv "colorschemes/RosePineMoon.colors" "$COLOR_SCHEME_DIR/"
    echo "Moved RosePineMoon.colors to $COLOR_SCHEME_DIR."
else
    echo "Color scheme file for the 'Moon' variant does not exist."
    exit 1
fi

# Final instructions
echo "Now, please go to System Settings > Appearance > Colors to select the new color scheme."
echo "Installation complete!"

