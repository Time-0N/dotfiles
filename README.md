# Dotfiles

My personal Hyprland configuration for Arch Linux with a glassy, modern aesthetic.

## Preview

- **WM**: Hyprland
- **Terminal**: Kitty with transparency
- **Shell**: Zsh
- **Bar**: Waybar
- **Browser**: Zen Browser
- **Editor**: Neovim (LazyVim)
- **Theme**: WhiteSur Kvantum with glassmorphism
- **Lock Screen**: swaylock-effects
- **Screenshots**: grim + slurp + satty

## Quick Install

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script will:
- Install all necessary packages (pacman + AUR)
- Backup your existing configs
- Copy dotfiles to `~/.config`
- Set up Fish shell
- Configure Qt themes

## Manual Install

If you prefer manual installation:

### 1. Install Dependencies

**Core packages:**
```bash
sudo pacman -S hyprland kitty waybar swaylock-effects cava neovim \
               kvantum grim slurp satty wl-clipboard qt5ct qt6ct \
               fish hypridle hyprlock
```

**AUR packages:**
```bash
yay -S zen-browser-bin grimblast-git swappy
```

### 2. Copy Configs

```bash
cp -r ~/dotfiles/hypr ~/.config/
cp -r ~/dotfiles/kitty ~/.config/
cp -r ~/dotfiles/waybar ~/.config/
cp -r ~/dotfiles/swaylock ~/.config/
cp -r ~/dotfiles/Kvantum ~/.config/
cp -r ~/dotfiles/cava ~/.config/
cp -r ~/dotfiles/nvim ~/.config/
```

### 3. Make Scripts Executable

```bash
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/scripts/*.sh
```

### 4. Set Fish as Default Shell

```bash
chsh -s $(which fish)
```

## Configuration Structure

```
dotfiles/
├── hypr/              # Hyprland config
│   ├── hyprland.conf  # Main config
│   ├── config/        # Split configs
│   │   ├── animations.conf
│   │   ├── windowrules.conf
│   │   └── environment.conf
│   └── scripts/       # Utility scripts
├── kitty/             # Terminal config
│   └── kitty.conf
├── waybar/            # Status bar
│   ├── config
│   ├── style.css
│   ├── colors.css
│   ├── modules.json
│   └── scripts/
├── swaylock/          # Lock screen
│   └── config
├── Kvantum/           # Qt theming
│   └── WhiteSur/
├── cava/              # Audio visualizer
│   ├── themes/
│   └── shaders/
└── nvim/              # Neovim (LazyVim)
    └── lua/config/
```

## Key Features

### Glassmorphism Theme
- Transparent terminals and windows with blur
- WhiteSur Kvantum theme for Qt apps
- Dynamic opacity (focused windows are opaque, unfocused are glassy)

### Keybindings

**Main modifier:** `SUPER` (Windows key)

| Keybind | Action |
|---------|--------|
| `SUPER + Return` | Open terminal (Kitty) |
| `SUPER + Q` | Close window |
| `SUPER + SHIFT + S` | Screenshot (region with Satty) |
| `SUPER + L` | Lock screen |
| `SUPER + M` | Exit Hyprland |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Toggle fullscreen |

### Window Rules

- **Zen Browser**: Transparent when unfocused, opaque when focused
- **Kitty**: 85% opacity with blur
- **Floating windows**: Centered with rounded corners

### Scripts

**Hypr scripts:**
- `wallpaper-slideshow.sh` - Automatic wallpaper rotation
- `waybar-launch.sh` - Waybar startup script

**Waybar scripts:**
- `cava.sh` - Audio visualizer module
- `os_logo.sh` - Display OS logo
- `check_updates.sh` - Check for system updates (WIP)
- `update_system.sh` - Update system (WIP)

## Post-Install Setup

### 1. Configure Qt Themes

```bash
qt6ct  # Set style to "kvantum"
qt5ct  # Set style to "kvantum"
kvantummanager  # Select "WhiteSur" theme
```

### 2. Set Wallpaper

Place your wallpaper in `~/Pictures/wallpaper.jpg` or update the path in:
- `~/.config/hypr/hyprland.conf`
- `~/.config/swaylock/config`

### 3. Configure Neovim

First launch will install all plugins automatically via LazyVim.

## Customization

### Change Opacity

Edit `~/.config/hypr/config/windowrules.conf`:
```bash
windowrulev2 = opacity 0.95 0.90,class:^(kitty)$
#                      ^^^^  ^^^^ 
#                      active  inactive
```

### Change Blur Strength

Edit `~/.config/hypr/hyprland.conf`:
```bash
blur {
    size = 15      # Higher = more blur
    passes = 5     # More passes = stronger blur
}
```

### Waybar Modules

Edit `~/.config/waybar/modules.json` to add/remove modules.

## Troubleshooting

**Waybar not showing:**
```bash
killall waybar
~/.config/hypr/scripts/waybar-launch.sh
```

**Zen Browser not transparent:**
```bash
hyprctl clients | grep -i zen  # Check window class
```

**Scripts not executing:**
```bash
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/scripts/*.sh

## Credits

- WhiteSur theme by vinceliuice
- LazyVim by folke
- CachyOS
```

## License

Feel free to use and modify as you like!
