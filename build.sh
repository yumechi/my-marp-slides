#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SLIDES_DIR="${SCRIPT_DIR}/slides"
IMAGE_NAME="docker.io/marpteam/marp-cli:latest"

if [ -z "$1" ]; then
    echo "Usage: $0 <slide-name>"
    echo "Example: $0 sample"
    echo ""
    echo "Available slides:"
    for dir in "${SLIDES_DIR}"/*/; do
        if [ -d "$dir" ] && [ -f "${dir}slides.md" ]; then
            echo "  - $(basename "$dir")"
        fi
    done
    exit 1
fi

SLIDE_NAME="$1"
SLIDE_DIR="${SLIDES_DIR}/${SLIDE_NAME}"
MD_FILE="${SLIDE_DIR}/slides.md"

if [ ! -d "$SLIDE_DIR" ]; then
    echo "Error: Directory not found: ${SLIDE_DIR}"
    exit 1
fi

if [ ! -f "$MD_FILE" ]; then
    echo "Error: slides.md not found in ${SLIDE_DIR}"
    exit 1
fi

echo "Converting: ${SLIDE_NAME}/slides.md -> ${SLIDE_NAME}/${SLIDE_NAME}.pdf"

podman run --rm \
    --security-opt label=disable \
    -v "${SLIDE_DIR}:/work" \
    -w /work \
    "${IMAGE_NAME}" \
    --pdf \
    --allow-local-files \
    "slides.md" \
    -o "${SLIDE_NAME}.pdf"

echo "Done! PDF generated: ${SLIDE_DIR}/${SLIDE_NAME}.pdf"
