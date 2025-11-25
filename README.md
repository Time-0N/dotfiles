# Dotfiles

My personal Hyprland configuration.

## Preview

- **WM**: Hyprland
- **Terminal**: Kitty
- **Shell**: Zsh
- **Bar**: Waybar
- **Editor**: Neovim (LazyVim)
- **App Launcher**: Walker (blur config included)
- **Theme**: MateriaDark Kvantum
- **Lock Screen**: swaylock-effects
- **Screenshots**: grim + slurp + satty

## Quick Install

```bash
git clone https://github.com/Time-0N/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The setup script will:
- Install all necessary packages (pacman + AUR)
- Backup your existing configs
- Copy dotfiles to `~/.config`
- Set up Zsh shell
- Set up Walker
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
cp -r ~/dotfiles/walker ~/.config/
```

### 3. Make Scripts Executable

```bash
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/scripts/*.sh
```

### 4. Set Zsh as Default Shell

```bash
chsh -s $(which zsh)
```

## Configuration Structure

```
dotfiles/
├── cava
│   ├── shaders
│   └── themes
├── hypr
│   ├── config
│   ├── hyprland.conf
│   └── scripts
├── kitty
│   └── kitty.conf
├── Kvantum
│   ├── kvantum.kvconfig
│   ├── Orchis
│   └── WhiteSur
├── nvim
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lazyvim.json
│   ├── LICENSE
│   ├── lua
│   ├── README.md
│   └── stylua.toml
├── README.md
├── setup.sh
├── swaylock
│   └── config
├── walker
│   ├── config.toml
│   └── themes
└── waybar
    ├── colors.css
    ├── config
    ├── modules.json
    ├── scripts
    └── style.css
```

### Keybindings

**Main modifier:** `SUPER` (Windows key)

| Keybind | Action |
|---------|--------|
| `SUPER + Return` | Open terminal (Kitty) |
| `SUPER + Q` | Close window |
| `SUPER + SHIFT + S` | Screenshot (region with Satty) |
| `SUPER + L` | Lock screen |
| `SUPER + SHIFT + M` | Open wlogout |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + SHIFT + B` | Reload Waybar |

### Window Rules

- **Zen Browser**: Transparent when unfocused, opaque when focused
- **Walker**: Blur effect

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

Place your wallpapers in `~/Pictures/Wallpaper/slideshow/` or update the path in:
- hypr/scripts/wallpaper-slideshow.sh

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

--

**Waybar not showing:**
```bash
killall waybar
~/.config/hypr/scripts/waybar-launch.sh
```
or use the shortcut `SUPER + SHIFT + B` to reload waybar

--

**Zen Browser not transparent:**
```bash
hyprctl clients | grep -i zen  # Check window class

--
```

**Scripts not executing:**
```bash
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/scripts/*.sh

--

Some modules (like CAVA) require proper UTF-8 locale support. If you see broken Unicode characters:

1. Edit `/etc/locale.gen` and uncomment your locale (e.g., `en_US.UTF-8 UTF-8`)
2. Run `sudo locale-gen`
3. Reload Waybar # SUPER + SHIFT + B

--

## Credits

- WhiteSur theme by vinceliuice
- LazyVim by folke
- CachyOS
```

## License

Feel free to use and modify as you like!
And I use Arch btw. ;)
