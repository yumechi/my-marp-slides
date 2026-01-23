#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/src"
OUTPUT_DIR="${SCRIPT_DIR}/slides"
IMAGE_NAME="marp-slides-jp"
CUSTOM_CSS_NAME="custom.css"
IMAGE_REF="${IMAGE_NAME}:latest"

# Build custom image only when:
# - the image doesn't exist, OR
# - the user explicitly requests build with --build / -b
build_image() {
    local force_build="${1:-0}"

    if ! podman image exists "${IMAGE_REF}"; then
        force_build=1
    fi

    if [ "${force_build}" -eq 1 ]; then
        echo "Building custom Marp image with Japanese fonts..."
        podman build -t "${IMAGE_NAME}" -f "${SCRIPT_DIR}/Containerfile" "${SCRIPT_DIR}"
    else
        echo "Using existing image: ${IMAGE_REF} (--build to rebuild)"
    fi
}

FORCE_BUILD=0
SLIDE_NAME=""

while [ $# -gt 0 ]; do
    case "$1" in
        -b|--build)
            FORCE_BUILD=1
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--build|-b] <slide-name>"
            echo "Example: $0 sample"
            echo "Example (force build): $0 --build sample"
            echo ""
            echo "Options:"
            echo "  -b, --build   Force podman build of the image"
            echo "  -h, --help    Show this help"
            exit 0
            ;;
        -*)
            echo "Error: Unknown option: $1"
            echo "Usage: $0 [--build|-b] <slide-name>"
            exit 1
            ;;
        *)
            SLIDE_NAME="$1"
            shift
            ;;
    esac
done

if [ -z "${SLIDE_NAME}" ]; then
    echo "Usage: $0 [--build|-b] <slide-name>"
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
build_image "${FORCE_BUILD}"

echo "Converting: src/${SLIDE_NAME}/slides.md -> slides/${SLIDE_NAME}.pdf"

# Remove existing PDF to avoid permission issues on overwrite
rm -f "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

# Build theme-set option when custom.css exists.
# (Keep custom.css filename fixed via CUSTOM_CSS_NAME.)
# This handles both @import references and theme: custom-* usage.
THEME_OPT=""
CUSTOM_CSS_HOST_PATH="${SRC_SLIDE_DIR}/assets/${CUSTOM_CSS_NAME}"
CUSTOM_CSS_CONTAINER_PATH="/src/assets/${CUSTOM_CSS_NAME}"
if [ -f "${CUSTOM_CSS_HOST_PATH}" ]; then
    THEME_OPT="--theme-set ${CUSTOM_CSS_CONTAINER_PATH}"
fi

podman run --rm \
    --security-opt label=disable \
    -v "${SRC_SLIDE_DIR}:/src:ro" \
    -v "${OUTPUT_DIR}:/out" \
    -w /src \
    "${IMAGE_REF}" \
    ${THEME_OPT} \
    --pdf \
    --allow-local-files \
    "slides.md" \
    -o "/out/${SLIDE_NAME}.pdf"

# Fix ownership to current user
podman unshare chown 0:0 "${OUTPUT_DIR}/${SLIDE_NAME}.pdf"

echo "Done! PDF generated: ${OUTPUT_DIR}/${SLIDE_NAME}.pdf"
