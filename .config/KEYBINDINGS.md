# Keyboard Shortcuts Reference

Complete keyboard shortcuts for all tools in the dotfiles setup.

---

## 🐚 Shell (Zsh)

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

---

## 🪟 Aerospace (Window Manager)

### Launch Applications
- `Alt + Enter` → Launch WezTerm
- `Ctrl + Enter` → Launch Ghostty
- `Alt + W` → Launch Zen Browser

### Window Focus (Dvorak Layout)
- `Alt + H` → Focus left window
- `Alt + N` → Focus down window
- `Alt + T` → Focus up window
- `Alt + S` → Focus right window

### Move Windows (Dvorak Layout)
- `Alt + Shift + H` → Move window left
- `Alt + Shift + N` → Move window down
- `Alt + Shift + T` → Move window up
- `Alt + Shift + S` → Move window right

### Workspaces
- `Alt + 1-9, 0` → Switch to workspace 1-10
- `Alt + Shift + 1-9, 0` → Move window to workspace 1-10
- `Alt + Tab` → Switch to previous workspace

### Layout & Resize
- `Alt + F` → Toggle fullscreen
- `Alt + /` → Toggle tiles layout (horizontal/vertical)
- `Alt + ,` → Toggle accordion layout
- `Alt + Shift + -` → Decrease window size
- `Alt + Shift + =` → Increase window size
- `Alt + Shift + C` → Reload Aerospace config

### Service Mode
- `Alt + Shift + ;` → Enter service mode
- `Esc` (in service mode) → Reload config and exit
- `R` (in service mode) → Reset layout (flatten workspace tree)
- `F` (in service mode) → Toggle floating/tiling layout
- `Backspace` (in service mode) → Close all windows but current

---

## 💻 WezTerm (Terminal Emulator)

### Config & Inspector
- `Cmd + R` or `Ctrl + R` → Reload configuration
- `Cmd + I` or `Ctrl + I` → Toggle inspector

### Screen & Clipboard
- `Cmd + K` or `Ctrl + K` → Clear screen and scrollback
- `Ctrl + Shift + C` → Copy to clipboard
- `Ctrl + Shift + V` → Paste from clipboard
- `Shift + Enter` → Insert newline

### Zellij Tab Switching (via WezTerm)
- `Cmd + 1-9` → Switch to Zellij tab 1-9 (sends Ctrl+Space + number)

**Note:** WezTerm auto-reloads configuration on file changes.

---

## 🔲 Zellij (Terminal Multiplexer)

### Session Management
- `Ctrl + Q` → Detach from session (keeps it alive)
- `zellij attach <name>` → Attach to existing session
- `zellij delete-session <name>` → Delete session

### Session Aliases (from shell)
- `tmd` → Dotfiles session (example)
- `tml` → List all sessions
- `tmk` → Delete session (prompts for name)
- `zm` → Interactive session picker (with fzf)
- `zm <name> [dir]` → Create/attach to named session

**Note:** Add custom project aliases in `.zsh.env` (private, gitignored):
```bash
alias tmp='zm pulumi ~/src/myproject'
alias tmw='zm work ~/work'
```

### Tab Navigation
- `Cmd + 1-9` → Go to tab 1-9 (via WezTerm)
- `Ctrl + Space` then `1-9` → Go to tab 1-9 (native)
- `Alt + N` → Next tab
- `Alt + P` → Previous tab

### Pane Management
Enter pane mode with `Ctrl + P`, then:
- `N` → New pane (split horizontally)
- `D` → New pane below (split vertically)
- `R` → New pane to the right
- `X` → Close current pane
- `H/J/K/L` or Arrow keys → Navigate panes
- `F` → Toggle fullscreen
- `Z` → Toggle pane frames
- `C` → Rename pane
- `Esc` → Exit pane mode

### Tab Management
Enter tab mode with `Ctrl + T`, then:
- `N` → New tab
- `X` → Close current tab
- `R` → Rename tab
- `H/L` or Arrow keys → Navigate tabs
- `Esc` → Exit tab mode

### Resize Mode
Enter resize mode with `Ctrl + N`, then:
- `H/J/K/L` or Arrow keys → Resize panes
- `+` or `=` → Increase size
- `-` → Decrease size
- `Esc` → Exit resize mode

### Scroll Mode
- `Ctrl + S` → Enter scroll mode
- `J/K` or Arrow keys → Scroll up/down
- `Ctrl + F` / `Ctrl + B` → Page down/up
- `G` → Go to top
- `Shift + G` → Go to bottom
- `Esc` → Exit scroll mode

### Search Mode
- `Ctrl + S` then `/` → Search forward
- `Ctrl + S` then `?` → Search backward
- `N` → Next match
- `Shift + N` → Previous match

---

## 📝 NvChad (Neovim)

### General
- `Space` → Leader key
- `:q` → Quit
- `:w` → Save
- `:wq` → Save and quit
- `Ctrl + S` → Save (insert mode)

### File Tree (NvimTree)
- `Ctrl + N` → Toggle file tree
- `Enter` → Open file/folder
- `H` → Toggle hidden files
- `I` → Toggle gitignored files
- `R` → Refresh tree
- `A` → Create new file/folder
- `D` → Delete file/folder
- `R` → Rename file/folder
- `C` → Copy file
- `X` → Cut file
- `P` → Paste file
- `Y` → Copy filename
- `G` → Go to top
- `Shift + G` → Go to bottom
- `]` → Next git item
- `[` → Previous git item
- `?` → Show help

### File Search & Navigation
- `Leader + FF` → Find files (Telescope)
- `Leader + FA` → Find all files (including hidden)
- `Leader + FW` → Find word (grep)
- `Leader + FB` → Find buffers
- `Leader + FH` → Find help
- `Leader + FO` → Find old files (recent)
- `Leader + FZ` → Find in current buffer
- `Leader + CM` → Git commits
- `Leader + GT` → Git status

### Buffer Management
- `Tab` → Next buffer
- `Shift + Tab` → Previous buffer
- `Leader + X` → Close buffer
- `Leader + B` → New buffer

### Window Management
- `Ctrl + H` → Move to left window
- `Ctrl + L` → Move to right window
- `Ctrl + J` → Move to bottom window
- `Ctrl + K` → Move to top window
- `Ctrl + W + S` → Split horizontally
- `Ctrl + W + V` → Split vertically
- `Ctrl + W + Q` → Close window

### Terminal
- `Leader + H` → Toggle horizontal terminal
- `Leader + V` → Toggle vertical terminal
- `Alt + H/V/I` → Toggle terminal (from terminal)
- `Esc Esc` → Exit terminal mode

### Code Navigation
- `GD` → Go to definition
- `GR` → Go to references
- `GI` → Go to implementation
- `K` → Show hover documentation
- `Leader + RA` → Rename symbol
- `Leader + CA` → Code actions
- `[D` → Previous diagnostic
- `]D` → Next diagnostic

### LSP & Formatting
- `Leader + FM` → Format code
- `Leader + DS` → Document symbols
- `Leader + WA` → Add workspace folder
- `Leader + WR` → Remove workspace folder

### Commenting
- `Leader + /` → Toggle comment (normal/visual mode)
- `GCC` → Toggle line comment
- `GBC` → Toggle block comment

### Visual Mode
- `V` → Visual line mode
- `Ctrl + V` → Visual block mode
- `>` → Indent right
- `<` → Indent left

---

## 🎯 Quick Reference

### Most Used Shortcuts

**Launch Apps:**
- Alt + Enter → WezTerm
- Alt + W → Browser

**Window Management:**
- Alt + 1-9 → Switch workspace
- Alt + H/N/T/S → Focus windows (Dvorak)
- Alt + F → Fullscreen

**Zellij:**
- Cmd + 1-9 → Switch tabs
- Ctrl + Q → Detach
- zm → Session picker

**NvChad:**
- Ctrl + N → File tree
- Space + FF → Find files
- Space + FW → Find word
- GD → Go to definition

---

## 📚 Notes

- **Dvorak Layout**: Aerospace uses Dvorak layout mappings (H/N/T/S instead of H/J/K/L)
- **WezTerm Auto-reload**: Configuration changes apply immediately
- **Zellij Sessions**: Persist between terminal closures - use `Ctrl+Q` to detach, not close
- **NvChad Leader**: `Space` key is the leader - most commands start with it
- **macOS Conflicts**: Ctrl+Space conflict with input source switching was disabled in System Settings

---

*For more details, see individual configuration files in `.config/`*
