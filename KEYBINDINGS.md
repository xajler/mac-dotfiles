# Keybindings Reference

Complete reference for all keyboard shortcuts used in this setup.

## Shell (Zsh)

### Navigation & Editing
| Key | Action |
|-----|--------|
| `Ctrl+a` | Jump to start of line |
| `Ctrl+e` | Jump to end of line |
| `Ctrl+b` | Move backward one character |
| `Ctrl+f` | Move forward one character (also accepts autosuggestion) |
| `Alt+.` | Insert last argument from previous command |
| `Ctrl+x Ctrl+e` | Edit current command in `$EDITOR` (nvim) |

### History
| Key | Action |
|-----|--------|
| `Ctrl+p` | Search backward in history |
| `Ctrl+n` | Search forward in history |
| `Ctrl+r` | Fuzzy search history (atuin/fzf) |

### FZF Navigation (when in fzf prompt)
| Key | Action |
|-----|--------|
| `Ctrl+p` | Previous item in list |
| `Ctrl+n` | Next item in list |

## Tmux (Terminal Multiplexer)

**Prefix Key:** `Ctrl+Space`

### Session Management
| Key | Action |
|-----|--------|
| `tm` | Interactive session picker (fzf) |
| `tm <name>` | Create/attach to named session |
| `tmd` | Quick access to "dotfiles" session |
| `tmw` | Quick access to "work" session |
| `tml` | List all sessions |
| `Ctrl+Space d` | Detach from session (keeps running) |

### Window Navigation
| Key | Action |
|-----|--------|
| `Cmd+1` through `Cmd+9` | Jump to window 1-9 ⭐ Fastest! |
| `Ctrl+Space 1` through `Ctrl+Space 9` | Jump to window 1-9 (manual) |
| `Alt+n` | Next window |
| `Alt+p` | Previous window |
| `Ctrl+Space n` | Next window (with prefix) |
| `Ctrl+Space p` | Previous window (with prefix) |

### Configuration
| Key | Action |
|-----|--------|
| `Ctrl+Space r` | Reload tmux config |

## Window Manager (Aerospace)

**Note:** This setup uses **Dvorak** keyboard layout.

### Main Mode

#### Application Launchers
| Key | Action |
|-----|--------|
| `Alt+Enter` | Open Ghostty terminal |
| `Alt+w` | Open Zen Browser |

#### Focus Management
| Key | Action |
|-----|--------|
| `Alt+h` | Focus left window |
| `Alt+n` | Focus down window |
| `Alt+t` | Focus up window |
| `Alt+s` | Focus right window |

#### Window Movement
| Key | Action |
|-----|--------|
| `Alt+Shift+h` | Move window left |
| `Alt+Shift+n` | Move window down |
| `Alt+Shift+t` | Move window up |
| `Alt+Shift+s` | Move window right |

#### Window Sizing
| Key | Action |
|-----|--------|
| `Alt+Shift+-` | Decrease window size by 50px |
| `Alt+Shift+=` | Increase window size by 50px |

#### Layout Management
| Key | Action |
|-----|--------|
| `Alt+f` | Toggle fullscreen |
| `Alt+/` | Toggle tiles layout (horizontal/vertical) |
| `Alt+,` | Toggle accordion layout (horizontal/vertical) |

#### Workspace Navigation
| Key | Action |
|-----|--------|
| `Alt+1` through `Alt+0` | Switch to workspace 1-10 |
| `Alt+Tab` | Switch to previous workspace |

#### Move Window to Workspace
| Key | Action |
|-----|--------|
| `Alt+Shift+1` through `Alt+Shift+0` | Move window to workspace 1-10 |
| `Alt+Shift+Tab` | Move workspace to next monitor |

#### Configuration
| Key | Action |
|-----|--------|
| `Alt+Shift+c` | Reload aerospace config |
| `Alt+Shift+;` | Enter service mode |

### Service Mode

Service mode is for advanced window management operations. Enter with `Alt+Shift+;`.

#### Basic Actions
| Key | Action |
|-----|--------|
| `Esc` | Exit service mode (and reload config) |
| `r` | Reset layout (flatten workspace tree) |
| `f` | Toggle floating/tiling layout |
| `Backspace` | Close all windows except current |

#### Join Windows
| Key | Action |
|-----|--------|
| `Alt+Shift+←` | Join with left window |
| `Alt+Shift+↓` | Join with down window |
| `Alt+Shift+↑` | Join with up window |
| `Alt+Shift+→` | Join with right window |

## Workspace Assignments

Applications automatically open in specific workspaces:

| Workspace | Applications |
|-----------|-------------|
| 1 | WezTerm |
| 2 | Arc Browser |
| 3 | Cursor IDE, IntelliJ IDEA |
| 5 | Zen Browser |
| 7 | Microsoft Teams |
| 8 | Slack |
| 9 | Telegram, WhatsApp, Chrome |
| 10 | KeePassXC |

## Tips

- **Service Mode**: Use for complex window operations. Always exits back to main mode after action.
- **Dvorak Layout**: All keybindings are mapped for Dvorak keyboard layout.
- **History Search**: `Ctrl+r` with atuin provides enhanced search with statistics and sync.
- **Last Argument**: Press `Alt+.` multiple times to cycle through previous command arguments.
- **Command Editing**: Long command? Use `Ctrl+x Ctrl+e` to edit in full nvim environment.
