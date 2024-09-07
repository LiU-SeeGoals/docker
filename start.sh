#!/bin/bash

# ANSI color codes for eye-popping effect
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Prompt the user to choose the configuration
echo "Select Docker Compose configuration:"
echo "1. Base configuration (GHCR images for both services)"
echo "2. Local controller, GHCR game viewer"
echo "3. GHCR controller, local game viewer"
echo "4. Local controller and local game viewer"
read -p "Enter your choice (1-4): " choice

echo -e "${CYAN}closing previous containers${NC}"
docker-compose down
# Define Docker Compose command based on the user's choice
case $choice in
  1)
    echo "Starting base configuration..."
    docker-compose up -d
    ;;
  2)
    if [ -d "../controller" ]; then
      echo "Starting with local controller and GHCR game viewer..."
      docker-compose -f docker-compose.yml -f docker-compose.local-controller.yml up -d
      echo -e "${CYAN}Website: ${RED}http://localhost:5173/${NC}"
      echo -e "${CYAN}Entering controller container...${NC}"
      docker-compose exec controller bash
    else
      echo -e "${RED}Error: 'controller' directory not found at ../controller. Please check the path.${NC}"
    fi
    ;;
  3)
    if [ -d "../GameViewer" ]; then
      echo "Starting with local game viewer and GHCR controller..."
      docker-compose -f docker-compose.yml -f docker-compose.local-gameviewer.yml up -d
      echo -e "${CYAN}Website: ${RED}http://localhost:5173/${NC}"
      echo -e "${CYAN}Entering game-viewer container...${NC}"
      docker-compose exec game-viewer bash
    else
      echo -e "${RED}Error: 'GameViewer' directory not found at ../GameViewer. Please check the path.${NC}"
    fi
    ;;
  4)
    if [ -d "../controller" ] && [ -d "../GameViewer" ]; then
      echo "Starting with local controller and local game viewer..."
      docker-compose -f docker-compose.yml -f docker-compose.local-controller.yml -f docker-compose.local-gameviewer.yml up -d
      echo -e "${GREEN}Both controller and game-viewer are local. Not entering any container.${NC}"
      echo -e "${CYAN}Website: ${RED}http://localhost:5173/${NC}"
    else
      echo -e "${RED}Error: 'controller' or 'GameViewer' directory not found at the expected paths. Please check the paths.${NC}"
    fi
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac

