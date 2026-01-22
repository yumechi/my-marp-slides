#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/src"
OUTPUT_DIR="${SCRIPT_DIR}/slides"
IMAGE_NAME="docker.io/marpteam/marp-cli:latest"

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

echo "Converting: src/${SLIDE_NAME}/slides.md -> slides/${SLIDE_NAME}.pdf"

# Remove existing PDF to avoid permission issues on overwrite
rm -f "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

podman run --rm \
    --security-opt label=disable \
    -v "${SRC_SLIDE_DIR}:/src:ro" \
    -v "${OUTPUT_DIR}:/out" \
    -w /src \
    "${IMAGE_NAME}" \
    --pdf \
    --allow-local-files \
    "slides.md" \
    -o "/out/${SLIDE_NAME}.pdf"

# Fix ownership to current user
podman unshare chown 0:0 "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

echo "Done! PDF generated: ${OUTPUT_DIR}/${SLIDE_NAME}.pdf"
