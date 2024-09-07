# Color setup for Windows PowerShell
$red = "`e[31m"
$green = "`e[32m"
$cyan = "`e[36m"
$reset = "`e[0m"

# Prompt the user to choose the configuration
Write-Host "Select Docker Compose configuration:"
Write-Host "1. Base configuration (GHCR images for both services)"
Write-Host "2. Local controller, GHCR game viewer"
Write-Host "3. GHCR controller, local game viewer"
Write-Host "4. Local controller and local game viewer"
$choice = Read-Host "Enter your choice (1-4)"

# Define actions based on user's choice
switch ($choice) {
  1 {
    Write-Host "Starting base configuration..."
    docker-compose up -d
  }
  2 {
    if (Test-Path "../controller") {
      Write-Host "Starting with local controller and GHCR game viewer..."
      docker-compose -f docker-compose.yml -f docker-compose.local-controller.yml up -d
      Write-Host "$cyan Website: $red http://localhost:5173/ $reset"
      Write-Host "$cyan Entering controller container... $reset"
      docker-compose exec controller cmd # Use cmd or powershell for Windows containers
    }
    else {
      Write-Host "$red Error: 'controller' directory not found at ../controller. Please check the path. $reset"
    }
  }
  3 {
    if (Test-Path "../GameViewer") {
      Write-Host "Starting with GHCR controller and local game viewer..."
      docker-compose -f docker-compose.yml -f docker-compose.local-gameviewer.yml up -d
      Write-Host "$cyan Website: $red http://localhost:5173/ $reset"
      Write-Host "$cyan Entering game-viewer container... $reset"
      docker-compose exec game-viewer cmd
    }
    else {
      Write-Host "$red Error: 'GameViewer' directory not found at ../GameViewer. Please check the path. $reset"
    }
  }
  4 {
    if (Test-Path "../controller" -and Test-Path "../GameViewer") {
      Write-Host "Starting with local controller and local game viewer..."
      docker-compose -f docker-compose.yml -f docker-compose.local-controller.yml -f docker-compose.local-gameviewer.yml up -d
      Write-Host "$green Both controller and game-viewer are local. Not entering any container. $reset"
      Write-Host "$cyan Website: $red http://localhost:5173/ $reset"
    }
    else {
      Write-Host "$red Error: 'controller' or 'GameViewer' directory not found. Please check the paths. $reset"
    }
  }
  default {
    Write-Host "Invalid choice. Exiting..."
    exit
  }
}
