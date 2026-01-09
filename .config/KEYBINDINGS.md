# Keyboard Shortcuts Reference

Complete keyboard shortcuts for all tools in the dotfiles setup.

---

## 🐚 Shell (Zsh) - Emacs Mode

### Cursor Movement
| Key | Action |
|-----|--------|
| `Ctrl+a` | Jump to **start** of line |
| `Ctrl+e` | Jump to **end** of line |
| `Ctrl+b` | Move **backward** one character |
| `Ctrl+f` | Move **forward** one character (also accepts autosuggestion) |
| `Alt+b` | Move backward one **word** |
| `Alt+f` | Move forward one **word** |

### Editing (Cut/Paste)
| Key | Action |
|-----|--------|
| `Ctrl+k` | **Kill** (cut) from cursor to end of line |
| `Ctrl+u` | Kill from cursor to **start** of line |
| `Ctrl+w` | Kill **word** backward |
| `Alt+d` | Kill word forward |
| `Ctrl+y` | **Yank** (paste) last killed text |
| `Ctrl+d` | Delete character under cursor (or EOF if empty) |
| `Ctrl+h` | Delete character before cursor (backspace) |
| `Ctrl+t` | **Transpose** (swap) characters |
| `Alt+t` | Transpose words |

### History
| Key | Action |
|-----|--------|
| `Ctrl+r` | **Atuin** fuzzy search history |
| `Up/Down` | Navigate history |
| `Ctrl+p` | Previous history entry |
| `Ctrl+n` | Next history entry |
| `Alt+.` | Insert **last argument** from previous command |
| `Ctrl+x Ctrl+e` | Edit current command in `$EDITOR` (nvim) |

### Misc
| Key | Action |
|-----|--------|
| `Ctrl+l` | Clear screen (keeps scrollback) |
| `Ctrl+c` | Cancel current command |
| `Ctrl+z` | Suspend current process (use `fg` to resume) |
| `Tab` | Autocomplete (fzf-tab) |

### FZF/Atuin Navigation (when in picker)
| Key | Action |
|-----|--------|
| `Ctrl+p` / `Up` | Previous item |
| `Ctrl+n` / `Down` | Next item |
| `Enter` | Select and execute |
| `Tab` | Select and edit |
| `Esc` | Cancel |

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

### Zellij Integration (sent to Zellij)
| Key | Action |
|-----|--------|
| `Cmd+1` | Switch to tab 1 (shell) |
| `Cmd+2` | Switch to tab 2 (claude) |
| `Cmd+3` | Switch to tab 3 (nvim) |
| `Cmd+[` | Previous tab |
| `Cmd+]` | Next tab |
| `Cmd+d` | Split pane vertically (side by side) |

### WezTerm Native
| Key | Action |
|-----|--------|
| `Cmd+r` | Reload WezTerm config |
| `Cmd+k` | Clear screen **and** scrollback (nuclear) |
| `Cmd+c` | Copy selection to clipboard |
| `Cmd+v` | Paste from clipboard |
| `Ctrl+Shift+c` | Copy (alternative) |
| `Ctrl+Shift+v` | Paste (alternative) |
| `Shift+Enter` | Insert literal newline |

**Note:** WezTerm auto-reloads configuration on file changes.

---

## 🔲 Zellij (Terminal Multiplexer)

Zellij runs in **locked mode** by default - all keys pass through to shell/nvim.

### Always Available (even in locked mode)
| Key | Action |
|-----|--------|
| `Cmd+1/2/3` | Switch to tab 1/2/3 (via WezTerm) |
| `Cmd+[/]` | Previous/next tab (via WezTerm) |
| `Cmd+d` | Split pane vertically (via WezTerm) |
| `Ctrl+q` | **Detach** session (keeps it alive) |
| `Ctrl+g` | **Unlock** Zellij (enter normal mode) |

### Navigate Between Panes (after splitting)
1. `Ctrl+g` → Unlock Zellij
2. `Ctrl+p` → Enter pane mode
3. `h/j/k/l` → Move left/down/up/right
4. `Esc` → Exit pane mode (returns to normal, use `Ctrl+g` to re-lock)

### Session Management
| Command | Action |
|---------|--------|
| `zm` | Interactive session picker (fzf) |
| `zm <name> [dir]` | Create/attach to named session |
| `tml` | List all sessions |
| `tmk <name>` | Delete session |
| `tmd` | Dotfiles session |

**Tip:** Add custom project aliases in `.zsh.env`:
```bash
alias tmp='zm pulumi ~/src/myproject'
```

### After Unlocking (Ctrl+g)

Once unlocked, you can access Zellij modes. Press `Esc` to return to normal/locked.

**Pane Mode** (`Ctrl+p`):
- `r` → Split right | `d` → Split down | `x` → Close pane
- `h/j/k/l` → Navigate panes | `f` → Fullscreen

**Tab Mode** (`Ctrl+t`):
- `n` → New tab | `x` → Close tab | `r` → Rename
- `1-9` → Go to tab

**Resize Mode** (`Ctrl+n`):
- `h/j/k/l` → Resize | `+/-` → Increase/decrease

**Scroll Mode** (`Ctrl+s`):
- `j/k` → Scroll | `u/d` → Half page | `Ctrl+f/b` → Full page

### Copy/Paste in Terminal
- **Copy text**: Just select with mouse → auto-copies to clipboard
- **Scroll**: Mouse wheel works normally
- **Paste**: `Cmd+v` anywhere
- **Note**: In locked mode (default), mouse selection works seamlessly

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

### Copy/Paste (Clipboard Integration)
- `yy` → Yank (copy) current line to system clipboard
- `V` + `hjkl` + `y` → Visual select lines and yank to clipboard
- `v` + movement + `y` → Visual select characters and yank
- `yiw` → Yank inner word (cursor on word)
- `yap` → Yank a paragraph
- `p` → Paste from clipboard after cursor
- `P` → Paste before cursor
- **Note**: Clipboard integration via `clipboard = "unnamedplus"` - all yanks go to system clipboard

---

## 🎯 Quick Reference

### Daily Workflow

**Aerospace (Window Manager):**
- `Alt+Enter` → Launch WezTerm
- `Alt+1-9` → Switch workspace
- `Alt+H/N/T/S` → Focus windows (Dvorak)
- `Alt+F` → Fullscreen

**Zellij:**
- `Cmd+1/2/3` → Switch tabs
- `Cmd+d` → Split pane
- `Ctrl+g` → `Ctrl+p` → `h/j/k/l` → Navigate panes
- `Ctrl+q` → Detach session

**Shell (Emacs):**
- `Ctrl+r` → Atuin history search
- `Ctrl+a/e` → Start/end of line
- `Ctrl+k` → Kill to end of line
- `Ctrl+y` → Yank (paste killed text)
- `Ctrl+w` → Kill word backward

**NvChad:**
- `Ctrl+n` → File tree
- `Space+ff` → Find files
- `Space+fw` → Find word
- `gd` → Go to definition
- `y` → Yank to clipboard

**Copy/Paste:**
- **Terminal/Shell/Claude Code**: Select text with mouse (auto-copies)
- **Neovim**: `V` (visual line) → `hjkl` (select) → `y` (yank to clipboard)
- **Paste anywhere**: `Cmd+v`

---

## 📚 Notes

- **Zellij Locked Mode**: All keys pass through to shell/nvim. Mouse selection works seamlessly.
- **Zellij Sessions**: Persist between terminal closures - `Ctrl+q` detaches, doesn't kill
- **Dvorak Layout**: Aerospace uses H/N/T/S instead of H/J/K/L
- **WezTerm Auto-reload**: `Cmd+r` or automatic on file changes
- **NvChad Leader**: `Space` key - most commands start with it

---

*For more details, see individual configuration files in `.config/`*
