# Neovim & NvChad Keybindings

**Leader key:** `Space`

---

## Core Vim (The Fundamentals)

### Modes
| Key | Action |
|-----|--------|
| `i` | Insert mode (before cursor) |
| `a` | Insert mode (after cursor) |
| `I` | Insert at line beginning |
| `A` | Insert at line end |
| `o` | New line below, insert mode |
| `O` | New line above, insert mode |
| `v` | Visual mode (character) |
| `V` | Visual mode (line) |
| `Ctrl-v` | Visual block mode (rectangular) |
| `Esc` / `jk` | Return to normal mode |
| `:` / `;` | Command mode (`;` is your remap) |

### Motion
| Key | Action |
|-----|--------|
| `h j k l` | Left, down, up, right |
| `w` | Next word start |
| `W` | Next WORD start (whitespace-delimited) |
| `b` | Previous word start |
| `B` | Previous WORD start |
| `e` | Next word end |
| `E` | Next WORD end |
| `0` | Line start |
| `^` | First non-blank char |
| `$` | Line end |
| `gg` | File start |
| `G` | File end |
| `{` / `}` | Paragraph up/down |
| `%` | Matching bracket |
| `f{char}` | Find char forward (on line) |
| `F{char}` | Find char backward |
| `t{char}` | Till char forward |
| `T{char}` | Till char backward |
| `;` | Repeat f/F/t/T forward |
| `,` | Repeat f/F/t/T backward |
| `Ctrl-d` | Half page down |
| `Ctrl-u` | Half page up |
| `Ctrl-f` | Full page down |
| `Ctrl-b` | Full page up |
| `zz` | Center cursor on screen |
| `zt` | Cursor to top |
| `zb` | Cursor to bottom |

### Operators (verb + motion/text-object)
| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `gU` | Uppercase |
| `gu` | Lowercase |

**Examples:** `dw` delete word, `ci"` change inside quotes, `yap` yank paragraph

### Text Objects
| Key | Scope |
|-----|-------|
| `iw` / `aw` | Inner/around word |
| `is` / `as` | Inner/around sentence |
| `ip` / `ap` | Inner/around paragraph |
| `i"` / `a"` | Inner/around double quotes |
| `i'` / `a'` | Inner/around single quotes |
| `i)` / `a)` | Inner/around parentheses |
| `i]` / `a]` | Inner/around brackets |
| `i}` / `a}` | Inner/around braces |
| `it` / `at` | Inner/around HTML tag |

### Editing
| Key | Action |
|-----|--------|
| `x` | Delete char under cursor |
| `X` | Delete char before cursor |
| `r{char}` | Replace single char |
| `R` | Replace mode |
| `s` | Substitute char (delete + insert) |
| `S` / `cc` | Substitute line |
| `C` | Change to end of line |
| `D` | Delete to end of line |
| `J` | Join lines |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | Repeat last change |
| `p` | Paste after |
| `P` | Paste before |
| `"ay` | Yank to register 'a' |
| `"ap` | Paste from register 'a' |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |

### Search & Replace
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirm |
| `:s/old/new/g` | Replace in current line |
| `cgn` | Change next match (repeatable with `.`) |

### Marks & Jumps
| Key | Action |
|-----|--------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark |
| `` `{mark} `` | Jump to mark (exact position) |
| `'{mark}` | Jump to mark (line start) |
| `` `` `` | Jump back to last position |
| `Ctrl-o` | Jump back in jump list |
| `Ctrl-i` | Jump forward in jump list |
| `gd` | Go to definition |
| `gf` | Go to file under cursor |

---

## Visual Block Mode (Rectangular/Column Editing)

This is Vim's "multi-cursor-like" feature. Select a rectangular region.

| Key | Action |
|-----|--------|
| `Ctrl-v` | Enter visual block mode |
| `I` | Insert at start of each line (after `Esc`) |
| `A` | Append at end of each line (after `Esc`) |
| `c` | Change selected text on all lines |
| `d` / `x` | Delete block |
| `r{char}` | Replace all selected chars |
| `>` / `<` | Indent block |
| `$` | Extend selection to end of each line |

**Workflow Example - Add prefix to multiple lines:**
1. `Ctrl-v` to start block select
2. `j` or `k` to extend selection down/up
3. `I` to insert
4. Type your text
5. `Esc` - text appears on all lines

**Workflow Example - Change middle of multiple lines:**
1. Position cursor at start of text to change
2. `Ctrl-v` then `j/k` to select lines, `l` to widen
3. `c` to change
4. Type replacement
5. `Esc` - applied to all lines

---

## NvChad Specific

### General
| Key | Action |
|-----|--------|
| `Esc` | Clear search highlights |
| `Ctrl-s` | Save file |
| `Ctrl-c` | Copy whole file to clipboard |
| `<leader>n` | Toggle line numbers |
| `<leader>rn` | Toggle relative numbers |
| `<leader>ch` | Open NvCheatsheet |
| `<leader>fm` | Format file (conform.nvim) |

### Buffers (Tabs)
| Key | Action |
|-----|--------|
| `<leader>b` | New buffer |
| `Tab` | Next buffer |
| `Shift-Tab` | Previous buffer |
| `<leader>x` | Close buffer |

### Windows
| Key | Action |
|-----|--------|
| `Ctrl-h` | Focus window left |
| `Ctrl-l` | Focus window right |
| `Ctrl-j` | Focus window down |
| `Ctrl-k` | Focus window up |

### Insert Mode Navigation
| Key | Action |
|-----|--------|
| `Ctrl-b` | Beginning of line |
| `Ctrl-e` | End of line |
| `Ctrl-h` | Move left |
| `Ctrl-l` | Move right |
| `Ctrl-j` | Move down |
| `Ctrl-k` | Move up |

### NvimTree (File Explorer)
| Key | Action |
|-----|--------|
| `Ctrl-n` | Toggle NvimTree |
| `<leader>e` | Focus NvimTree |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fa` | Find all files (hidden + ignored) |
| `<leader>fw` | Live grep (search content) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fo` | Recent files (oldfiles) |
| `<leader>fz` | Fuzzy find in current buffer |
| `<leader>cm` | Git commits |
| `<leader>gt` | Git status |
| `<leader>ma` | Find marks |
| `<leader>pt` | Pick hidden terminal |
| `<leader>th` | NvChad themes |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>h` | New horizontal terminal |
| `<leader>v` | New vertical terminal |
| `Alt-h` | Toggle horizontal terminal |
| `Alt-v` | Toggle vertical terminal |
| `Alt-i` | Toggle floating terminal |
| `Ctrl-x` | Escape terminal mode |

### Comments
| Key | Action |
|-----|--------|
| `<leader>/` | Toggle comment (normal/visual) |
| `gcc` | Toggle line comment |
| `gc{motion}` | Comment motion |

### LSP
| Key | Action |
|-----|--------|
| `<leader>ds` | Diagnostic loclist |

### WhichKey
| Key | Action |
|-----|--------|
| `<leader>wK` | Show all keymaps |
| `<leader>wk` | Query specific keymap |

---

## Your Custom Mappings

### NvimTree Visual Selection Marking
| Key | Mode | Action |
|-----|------|--------|
| `m` | Visual | Mark files in selection |
| `<leader>mt` | Visual | Toggle marks in selection |
| `<leader>ma` | Visual | Add marks to selection |
| `<leader>md` | Visual | Remove marks from selection |

---

## Multi-Cursor Alternatives (The Vim Way)

Vim doesn't have true multi-cursor. Instead, use these patterns:

### cgn Pattern (Recommended)
1. `/pattern` - Search for text
2. `cgn` - Change next match
3. `.` - Repeat on next match
4. `n` to skip, `.` to apply

### Macro Pattern
1. `qa` - Start recording macro to register 'a'
2. Make your edit
3. `q` - Stop recording
4. `@a` - Play macro
5. `@@` - Repeat last macro
6. `10@a` - Play macro 10 times

### Substitute Pattern
```vim
:%s/old/new/gc   " Interactive replace
```

### Visual Block (for column edits)
See Visual Block Mode section above.

---

## Quick Reference Card

```
MOVEMENT          EDITING           VISUAL
h j k l           i a I A o O       v V Ctrl-v
w b e W B E       d c y p P         gv (reselect)
0 ^ $ gg G        x r R s S         o (other end)
{ } ( )           u Ctrl-r .
f t F T ; ,       J gU gu

SEARCH            TEXT OBJECTS      WINDOWS
/ ? n N * #       iw aw ip ap       Ctrl-w s (split)
:%s/x/y/g         i" a" i( a(       Ctrl-w v (vsplit)
cgn               it at             Ctrl-w hjkl
```

---

*Generated from your config at `~/.config/nvim/lua/mappings.lua`*
*Run `:NvCheatsheet` or `<leader>ch` for live cheatsheet*
