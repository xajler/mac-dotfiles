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

### Terminal & Shell
- **Zsh**: Shell configuration (`.zshrc`, `.zprofile`, `.zshenv`).
  - **Powerlevel10k**: Theme configuration (`.p10k.zsh`).
  - **Modern CLI tools**: bat (cat), eza (ls), atuin (history), direnv (env management).
  - **Ghostty**: Terminal emulator configuration (`.config/ghostty/`).
    - Custom shaders and themes.
- **Tmux**: Terminal multiplexer (`.tmux.conf`).
  - Session management with auto-save/restore
  - Smart session switcher with fzf
  - 3-window project layout (shell, claude, nvim)
- **Fastfetch**: System information fetch tool (`.config/fastfetch/`).
- **Git**: Global git configuration (`.config/git/`).
- **TFEnv**: Terraform version manager configuration (`.config/tfenv/`).

### Utilities
- **Raycast**: Productivity tool extensions and scripts (`.config/raycast/`).
- **Karabiner Elements**: Keyboard customization (`.config/karabiner/`).

## ⌨️ Keybindings

Quick access to keyboard shortcuts:
- [Shell (Zsh) keybindings](.config/KEYBINDINGS.md#shell-zsh) - Terminal navigation, history, editing
- [Tmux keybindings](.config/KEYBINDINGS.md#tmux-terminal-multiplexer) - Session management, window switching
- [Aerospace keybindings](.config/KEYBINDINGS.md#window-manager-aerospace) - Window management, workspaces, layouts
- [Service mode](.config/KEYBINDINGS.md#service-mode) - Advanced window operations

Full reference: [.config/KEYBINDINGS.md](.config/KEYBINDINGS.md)

## 🚀 Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:xajler/mac-dotfiles.git ~/mac-dotfiles
   # Or if you are cloning directly to home (be careful with existing files):
   # git init
   # git remote add origin ...
   # git pull origin master
   ```

2. **Secrets Management:**


   Create or copy `.zsh.env` file for private aliases and secrets (ignored by git):

   Secrets are stored in macOS Keychain for security. See [Security](#-security) section below.

   *Note: `.zsh.env` is gitignored to keep your private settings safe.*

## 📂 Structure

- `.config/`: Application configurations.
- `.zshrc`: Main shell configuration with Keychain integration.
- `.zsh.env`: Private aliases and settings (not tracked).
- `.tmux.conf`: Tmux configuration with session persistence.
- `.gitignore`: Custom ignore rules for dotfiles management.

## 🔐 Security

Sensitive data (API tokens, credentials) is stored in macOS Keychain, not in plain text files. The `.zsh.env` file loads these secrets on shell startup.

### Adding Secrets to Keychain

To store a new secret:
```bash
security add-generic-password -a "$USER" -s "SECRET_NAME" -w "your-secret-value"
```

Then add to your `.zsh.env`:
```bash
export SECRET_NAME=$(security find-generic-password -a "$USER" -s "SECRET_NAME" -w 2>/dev/null)
```

**Benefits:**
- Secrets encrypted by macOS Keychain
- No plain text tokens in dotfiles
- Safe to commit `.zshrc` to public repos
- Private settings stay in gitignored `.zsh.env`

## 📝 License

[GPLv3](LICENSE)

