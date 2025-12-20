# Dotfiles

My personal Hyprland configuration for an Arch-based setup.

## Preview

- **WM**: Hyprland
- **Terminal**: Kitty
- **Shell**: Zsh
- **Bar**: Waybar
- **Widgets**: Eww
- **Editor**: Neovim (LazyVim)
- **Theme (Qt)**: Kvantum (MateriaDark / WhiteSur in this repo)
- **Lock screen**: swaylock config included (Hypridle/Hyprlock supported)
- **Screenshots**: grim + slurp + satty (plus grimblast/swappy if installed)
- **Browser**: Zen (AUR)

## Quick setup

```bash
git clone https://github.com/Time-0N/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The setup script will:

- Install packages (pacman + AUR)
- Backup existing configs
- Copy tracked configs into `~/.config`
- Set up Zsh as the default shell
- Add basic Qt theming environment variables for Hyprland

Notes:

- This repo is intended for **Arch-based distros**.
- Qt theming is handled via **qt6ct/qt5ct + Kvantum**.

## Manual setup

### 1) Install dependencies

**Core packages (pacman):**

```bash
sudo pacman -S --needed \
  hyprland kitty waybar cava neovim kvantum \
  grim slurp satty wl-clipboard qt5ct qt6ct \
  zsh hypridle hyprlock swww playerctl \
  nm-connection-editor ttf-jetbrains-mono-nerd
```

**AUR packages (yay):**

```bash
yay -S --needed \
  zen-browser-bin grimblast-git swappy wlogout eww
```

### 2) Copy configs

```bash
cp -r ~/dotfiles/hypr ~/.config/
cp -r ~/dotfiles/kitty ~/.config/
cp -r ~/dotfiles/waybar ~/.config/
cp -r ~/dotfiles/swaylock ~/.config/
cp -r ~/dotfiles/Kvantum ~/.config/
cp -r ~/dotfiles/cava ~/.config/
cp -r ~/dotfiles/nvim ~/.config/
cp -r ~/dotfiles/eww ~/.config/
```

### 3) Make scripts executable (if present)

```bash
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/*.sh 2>/dev/null || true
```

### 4) Set Zsh as default shell

```bash
chsh -s "$(which zsh)"
```

## Keybindings

**Main modifier:** `SUPER`

| Keybind             | Action                         |
| ------------------- | ------------------------------ |
| `SUPER + Return`    | Open terminal (Kitty)          |
| `SUPER + Q`         | Close window                   |
| `SUPER + SHIFT + S` | Screenshot (region with Satty) |
| `SUPER + L`         | Lock screen                    |
| `SUPER + SHIFT + M` | Open wlogout                   |
| `SUPER + V`         | Toggle floating                |
| `SUPER + F`         | Toggle fullscreen              |
| `SUPER + SHIFT + B` | Reload Waybar                  |

## Behavior notes

- **Zen Browser**: configured for transparency (unfocused vs focused)
- **Launchers / widgets**: Eww is included; any launcher referenced in your Hypr config should be installed separately if it’s not in the package list

## Scripts

**Hypr scripts (if present):**

- `wallpaper-slideshow.sh` - automatic wallpaper rotation
- `waybar-launch.sh` - Waybar startup script

**Waybar scripts (if present):**

- `cava.sh` - audio visualizer module
- `os_logo.sh` - display OS logo
- `check_updates.sh` - check for system updates (WIP)
- `update_system.sh` - update system (WIP)

## Post-install setup

### 1) Configure Qt themes

```bash
qt6ct     # set style to "kvantum"
qt5ct     # set style to "kvantum"
kvantummanager  # select a theme (e.g. WhiteSur)
```

### 2) Wallpapers

If you use the slideshow script, place wallpapers in your configured directory
(or update the path in the script / Hypr config).

### 3) Neovim

First launch will install plugins automatically via LazyVim.

## Customization

### Opacity

Edit your Hypr window rules (example):

```conf
windowrulev2 = opacity 0.95 0.90,class:^(kitty)$
#                      ^^^^  ^^^^
#                      active  inactive
```

### Blur

Edit `~/.config/hypr/hyprland.conf` (example):

```conf
blur {
  size = 15
  passes = 5
}
```

### Waybar modules

Edit `~/.config/waybar/modules.json` to add/remove modules.

## Troubleshooting

**Waybar not showing:**

```bash
killall waybar
~/.config/hypr/scripts/waybar-launch.sh
```

or use `SUPER + SHIFT + B`.

**Zen Browser not transparent:**

```bash
hyprctl clients | grep -i zen
```

**Scripts not executing:**

```bash
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/scripts/*.sh
```

**Broken Unicode glyphs:**

1. Edit `/etc/locale.gen` and uncomment your locale (e.g. `en_US.UTF-8 UTF-8`)
2. Run `sudo locale-gen`
3. Restart Waybar

## Sync configs back into the repo (optional, recommended)

If you keep your “live” configs in `~/.config`, create a sync script in the repo
to copy only the tracked directories back into `~/dotfiles` before committing.

Example workflow:

```bash
./sync.sh
git status
git commit -am "sync configs"
git push
```

(If you don’t have a `sync.sh` yet, add one using `rsync` with an explicit allowlist.)

## Credits

- WhiteSur theme by vinceliuice
- LazyVim by folke
- Hyprland / Waybar / Kitty and the wider Wayland ecosystem

## License

Feel free to use and modify as you like.
And I use Arch btw. ;)
