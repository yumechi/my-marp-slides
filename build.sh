#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/src"
OUTPUT_DIR="${SCRIPT_DIR}/slides"
IMAGE_NAME="marp-slides-jp"

# Build custom image if not exists or Containerfile is newer
# Note: This function assumes Ubuntu (Linux) environment
build_image() {
    if ! podman image exists "${IMAGE_NAME}"; then
        echo "Building custom Marp image with Japanese fonts..."
        podman build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Containerfile" "${SCRIPT_DIR}"
        return
    fi
    
    # Check if Containerfile is newer than the image
    # Get Containerfile modification time (Unix timestamp)
    local containerfile_mtime
    containerfile_mtime=$(stat -c %Y "${SCRIPT_DIR}/Containerfile" 2>/dev/null)
    
    if [ -z "$containerfile_mtime" ]; then
        echo "Cannot determine Containerfile modification time. Rebuilding..."
        podman build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Containerfile" "${SCRIPT_DIR}"
        return
    fi
    
    # Get image creation time as Unix timestamp directly
    local image_unix_timestamp
    image_unix_timestamp=$(podman image inspect "${IMAGE_NAME}" --format '{{.Created.Unix}}' 2>/dev/null)
    
    if [ -z "$image_unix_timestamp" ]; then
        echo "Cannot determine image creation time. Rebuilding..."
        podman build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Containerfile" "${SCRIPT_DIR}"
        return
    fi
    
    if [ "$containerfile_mtime" -gt "$image_unix_timestamp" ]; then
        echo "Containerfile is newer than image. Rebuilding..."
        podman build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Containerfile" "${SCRIPT_DIR}"
    else
        echo "Using existing image: ${IMAGE_NAME} (Containerfile unchanged)"
    fi
}

if [ -z "$1" ]; then
    echo "Usage: $0 <slide-name>"
    echo "Example: $0 sample"
    echo ""
    echo "Available slides:"
    for dir in "${SRC_DIR}"/*/; do
        if [ -d "$dir" ] && [ -f "${dir}slides.md" ]; then
            echo "  - $(basename "$dir")"
        fi
    done
    exit 1
fi

SLIDE_NAME="$1"
SRC_SLIDE_DIR="${SRC_DIR}/${SLIDE_NAME}"
MD_FILE="${SRC_SLIDE_DIR}/slides.md"

if [ ! -d "$SRC_SLIDE_DIR" ]; then
    echo "Error: Directory not found: ${SRC_SLIDE_DIR}"
    exit 1
fi

if [ ! -f "$MD_FILE" ]; then
    echo "Error: slides.md not found in ${SRC_SLIDE_DIR}"
    exit 1
fi

# Build custom image
build_image

echo "Converting: src/${SLIDE_NAME}/slides.md -> slides/${SLIDE_NAME}.pdf"

# Remove existing PDF to avoid permission issues on overwrite
rm -f "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

# Build theme-set option if custom.css exists
THEME_OPT=""
if [ -f "${SRC_SLIDE_DIR}/assets/custom.css" ]; then
    THEME_OPT="--theme-set /src/assets/custom.css"
fi

podman run --rm \
    --security-opt label=disable \
    -v "${SRC_SLIDE_DIR}:/src:ro" \
    -v "${OUTPUT_DIR}:/out" \
    -w /src \
    "${IMAGE_NAME}" \
    ${THEME_OPT} \
    --pdf \
    --allow-local-files \
    "slides.md" \
    -o "/out/${SLIDE_NAME}.pdf"

# Fix ownership to current user
podman unshare chown 0:0 "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

echo "Done! PDF generated: ${OUTPUT_DIR}/${SLIDE_NAME}.pdf"
