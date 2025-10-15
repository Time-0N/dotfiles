#!/bin/bash

# Dotfiles Bootstrap Script
# This script installs all necessary packages and sets up configs

set -e # Exit on error

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Dotfiles Bootstrap Script ===${NC}\n"

# Check if running Arch-based distro
if ! command -v pacman &>/dev/null; then
  echo -e "${RED}Error: This script is for Arch-based distros only${NC}"
  exit 1
fi

# Function to install packages
install_packages() {
  echo -e "${YELLOW}Installing packages...${NC}"

  # Core packages
  sudo pacman -S --needed --noconfirm \
    hyprland \
    kitty \
    waybar \
    swaylock-effects \
    cava \
    neovim \
    kvantum \
    grim \
    slurp \
    satty \
    wl-clipboard \
    qt5ct \
    qt6ct \
    zsh \
    hypridle \
    hyprlock \
    swww \
    nm-connection-editor \
    waybar \
    cava \
    playerctl \
    ttf-jetbrains-mono-nerd

  echo -e "${GREEN}✓ Core packages installed${NC}\n"
}

# Function to install AUR packages
install_aur() {
  echo -e "${YELLOW}Installing AUR packages...${NC}"

  # Check if yay is installed
  if ! command -v yay &>/dev/null; then
    echo -e "${YELLOW}Installing yay...${NC}"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
  fi

  # AUR packages
  yay -S --needed --noconfirm \
    zen-browser-bin \
    grimblast-git \
    swappy \
    wlogout \
    otf-codenewroman-nerd \
    swaylock-effects

  echo -e "${GREEN}✓ AUR packages installed${NC}\n"
}

# Function to backup existing configs
backup_configs() {
  echo -e "${YELLOW}Backing up existing configs...${NC}"

  BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$BACKUP_DIR"

  [ -d "$CONFIG_DIR/hypr" ] && cp -r "$CONFIG_DIR/hypr" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/kitty" ] && cp -r "$CONFIG_DIR/kitty" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/waybar" ] && cp -r "$CONFIG_DIR/waybar" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/swaylock" ] && cp -r "$CONFIG_DIR/swaylock" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/Kvantum" ] && cp -r "$CONFIG_DIR/Kvantum" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/cava" ] && cp -r "$CONFIG_DIR/cava" "$BACKUP_DIR/"
  [ -d "$CONFIG_DIR/nvim" ] && cp -r "$CONFIG_DIR/nvim" "$BACKUP_DIR/"

  echo -e "${GREEN}✓ Backup created at $BACKUP_DIR${NC}\n"
}

# Function to copy dotfiles
copy_dotfiles() {
  echo -e "${YELLOW}Copying dotfiles...${NC}"

  mkdir -p "$CONFIG_DIR"

  # Copy configs
  cp -r "$DOTFILES_DIR/hypr" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/kitty" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/waybar" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/swaylock" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/Kvantum" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/cava" "$CONFIG_DIR/"
  cp -r "$DOTFILES_DIR/nvim" "$CONFIG_DIR/"

  # Make all scripts executable
  chmod +x "$CONFIG_DIR/hypr/scripts/"*.sh
  chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh

  echo -e "${GREEN}✓ Dotfiles copied${NC}\n"
}

# Function to set Zsh as default shell
setup_zsh() {
  echo -e "${YELLOW}Setting up Zsh shell...${NC}"

  if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${YELLOW}Changing default shell to Zsh...${NC}"
    chsh -s $(which zsh)
    echo -e "${GREEN}✓ Zsh set as default shell (restart required)${NC}\n"
  else
    echo -e "${GREEN}✓ Zsh already default shell${NC}\n"
  fi
}

# Function to setup Qt themes
setup_qt() {
  echo -e "${YELLOW}Setting up Qt configuration...${NC}"

  # Set environment variables for Hyprland
  if ! grep -q "QT_QPA_PLATFORMTHEME" "$CONFIG_DIR/hypr/hyprland.conf"; then
    echo -e "\n# Qt configuration" >>"$CONFIG_DIR/hypr/hyprland.conf"
    echo "env = QT_QPA_PLATFORMTHEME,qt6ct" >>"$CONFIG_DIR/hypr/hyprland.conf"
    echo "env = QT_STYLE_OVERRIDE,kvantum" >>"$CONFIG_DIR/hypr/hyprland.conf"
  fi

  echo -e "${GREEN}✓ Qt configuration added${NC}\n"
}

# Main execution
main() {
  echo -e "${YELLOW}This script will:${NC}"
  echo "1. Install all necessary packages"
  echo "2. Backup existing configs"
  echo "3. Copy dotfiles to ~/.config"
  echo "4. Set up Fish shell"
  echo "5. Configure Qt themes"
  echo ""
  read -p "Continue? (y/n) " -n 1 -r
  echo ""

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborted${NC}"
    exit 1
  fi

  install_packages
  install_aur
  backup_configs
  copy_dotfiles
  setup_zsh
  setup_qt

  echo -e "${GREEN}=== Bootstrap Complete! ===${NC}"
  echo -e "${YELLOW}Next steps:${NC}"
  echo "1. Log out and log back in to start Hyprland"
  echo "2. Run 'qt6ct' and 'kvantummanager' to configure themes"
  echo "3. Restart to use Fish shell"
  echo ""
  echo -e "${GREEN}Enjoy your setup!${NC}"
}

# Run main function
main
