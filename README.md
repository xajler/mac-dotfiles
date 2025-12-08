# macOS Dotfiles

A collection of configuration files for my macOS setup, managed with Git.

![Screenshot](screenshots/screenshot.png)

## 🛠 Configuration Included

### Window Management & Status Bar
- **[Aerospace](https://github.com/nikitabobko/AeroSpace)**: Tiling window manager configuration (`.config/aerospace/`).
  - Custom workspace scripts.
  - Gaps and focus management.
- **[SketchyBar](https://github.com/FelixKratz/SketchyBar)**: Highly customizable status bar (`.config/sketchybar/`).
  - Custom Lua configuration.
  - Dynamic workspace indicators with pastel colors.
  - Widgets: CPU, RAM, Battery, Volume, WiFi (with WAN IP), Brew updates.
- **[JankyBorders](https://github.com/FelixKratz/JankyBorders)**: Active window borders (`.config/borders/`).

### Terminal & Shell
- **Zsh**: Shell configuration (`.zshrc`, `.zprofile`, `.zshenv`).
  - **Powerlevel10k**: Theme configuration (`.p10k.zsh`).
  - **Ghostty**: Terminal emulator configuration (`.config/ghostty/`).
    - Custom shaders and themes.
- **Fastfetch**: System information fetch tool (`.config/fastfetch/`).
- **Git**: Global git configuration (`.config/git/`).
- **TFEnv**: Terraform version manager configuration (`.config/tfenv/`).

### Utilities
- **Raycast**: Productivity tool extensions and scripts (`.config/raycast/`).
- **Karabiner Elements**: Keyboard customization (`.config/karabiner/`).

## 🚀 Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:xajler/mac-dotfiles.git ~/mac-dotfiles
   # Or if you are cloning directly to home (be careful with existing files):
   # git init
   # git remote add origin ...
   # git pull origin master
   ```

2. **Environment Variables:**
   Copy the example environment file and add your secrets (tokens, keys):
   ```bash
   cp .zsh.env.example .zsh.env
   nano .zsh.env
   ```
   *Note: `.zsh.env` is ignored by git to keep secrets safe.*

## 📂 Structure

- `.config/`: Application configurations.
- `.zshrc`: Main shell configuration.
- `.zsh.env`: Secrets and tokens (not tracked).
- `.gitignore`: Custom ignore rules for dotfiles management.

## 📝 License

[GPLv3](LICENSE)

