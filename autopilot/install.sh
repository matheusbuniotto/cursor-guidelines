#!/usr/bin/env sh
#
# Autopilot install script — copies .cursor/ to project or global.
# Run from repo root: ./autopilot/install.sh
# Or from autopilot/: ./install.sh
#
# Interactive: prompts for project vs global.
# Non-interactive: ./install.sh --project | --global

set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
DIM='\033[0;2m'
RESET='\033[0m'

# Resolve script dir and repo root (autopilot/ is parent of script dir)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AUTOPILOT_DIR="${SCRIPT_DIR}"
# If we're in autopilot/, repo root is parent
REPO_ROOT="$(cd "${AUTOPILOT_DIR}/.." && pwd)"
SOURCE_CURSOR="${AUTOPILOT_DIR}/.cursor"

if [ ! -d "$SOURCE_CURSOR" ]; then
  echo "Error: .cursor not found at ${SOURCE_CURSOR}"
  exit 1
fi

# Parse args
INSTALL_LOCATION=""
for arg in "$@"; do
  case "$arg" in
    --project|-p) INSTALL_LOCATION="project" ;;
    --global|-g)  INSTALL_LOCATION="global" ;;
    --help|-h)
      echo ""
      echo "Autopilot install — copy .cursor/ to project or global Cursor config"
      echo ""
      echo "Usage: $0 [option]"
      echo ""
      echo "Options:"
      echo "  --project, -p   Install to current directory (project only)"
      echo "  --global, -g   Install to ~/.cursor/ (all projects)"
      echo "  (no option)     Prompt for project vs global"
      echo ""
      echo "Examples:"
      echo "  $0              # interactive"
      echo "  $0 --project    # install to current dir"
      echo "  $0 --global     # install to ~/.cursor/"
      echo ""
      exit 0
      ;;
  esac
done

# Prompt if not set
if [ -z "$INSTALL_LOCATION" ]; then
  echo ""
  echo "${YELLOW}Where do you want to install Autopilot?${RESET}"
  echo ""
  echo "  ${CYAN}1${RESET}) Project ${DIM}(current directory — this project only)${RESET}"
  echo "  ${CYAN}2${RESET}) Global  ${DIM}(~/.cursor/ — all projects)${RESET}"
  echo ""
  printf "Choice [1]: "
  read -r choice
  choice="${choice:-1}"
  if [ "$choice" = "2" ]; then
    INSTALL_LOCATION="global"
  else
    INSTALL_LOCATION="project"
  fi
fi

# Resolve destination
if [ "$INSTALL_LOCATION" = "global" ]; then
  DEST="${HOME}/.cursor"
  echo ""
  echo "Installing to ${CYAN}~/.cursor/${RESET} (global)"
else
  # Project = current working directory when script is run
  DEST="$(pwd)/.cursor"
  echo ""
  echo "Installing to ${CYAN}${DEST}${RESET} (project)"
fi

# Create destination and merge copy
mkdir -p "$DEST"
for dir in commands agents skills rules; do
  if [ -d "${SOURCE_CURSOR}/${dir}" ]; then
    mkdir -p "${DEST}/${dir}"
    # Copy contents (merge): copy each item so we don't remove existing files
    for item in "${SOURCE_CURSOR}/${dir}"/*; do
      [ -e "$item" ] || continue
      name="$(basename "$item")"
      if [ -d "$item" ]; then
        cp -R "$item" "${DEST}/${dir}/"
      else
        cp "$item" "${DEST}/${dir}/"
      fi
    done
  fi
done

echo ""
echo "${GREEN}Done.${RESET} Autopilot commands, agents, skills, and rules are installed."
echo ""
echo "In Cursor: type ${CYAN}/${RESET} in chat to see commands (pull, plan, launch, etc.). Run ${CYAN}/help${RESET} for the full list."
echo ""
