# 🛠️ Scleo's Portable Neovim Configuration

A high-performance, **single-file** Neovim setup designed for seamless portability across Windows, Linux, and macOS. This configuration balances a minimalist "vanilla-plus" feel with essential IDE power-ups.

## 🚀 Key Features
- **Zero-Touch Setup**: Automatically bootstraps the `lazy.nvim` plugin manager on first launch.
- **Smart Deletion**: `d` and `x` use the "Black Hole" register to prevent overwriting your clipboard.
- **OS-Aware Aesthetics**: Automatically switches themes based on your host operating system.
- **Hybrid Line Numbers**: Optimized for fast vertical movement using relative jumps.
- **Right-Side Navigation**: Persistent file explorer on the right to keep your code centered.

---

## 📂 Installation

1. **Copy** your `init.lua` to the configuration folder:
   - **Windows**: `%LOCALAPPDATA%\nvim\init.lua`
   - **Linux/macOS**: `~/.config/nvim/init.lua`
2. **Launch Neovim**. It will automatically download all required plugins.

*Note: A [Nerd Font](https://www.nerdfonts.com/) (e.g., JetBrainsMono Nerd Font) is required for file icons.*

---

## 🎨 Operating System Themes
The environment detects your platform to apply the best-suited aesthetic:
| Platform | Theme | Style |
| :--- | :--- | :--- |
| **Windows** | `Dracula` | Professional High-Contrast |
| **Linux** | `Gruvbox` | Retro-Material Warmth |
| **macOS/Other** | `Catppuccin` | Modern Pastel (w/ Transparency) |

---

## ⌨️ Global Keybindings
The **Leader Key** is set to `Space`.

| Key | Action |
| :--- | :--- |
| `<Space> + e` | **Focus Explorer**: Jump cursor to the file tree. |
| `d` | **Delete**: Remove text *without* overwriting your clipboard. |
| `x` | **Delete Char**: Remove character *without* overwriting your clipboard. |
| `y` | **Yank**: Copy text to system clipboard (as usual). |
---

## 🪟 Window & Pane Navigation
Instead of cycling through all panes, move directly in a specific direction using `CTRL-w` + `hjkl` (Vim keys) or the arrow keys. This is especially useful for jumping between the code and the **Nvim-Tree**.

| Direction | Shortcut | Alternative |
| :--- | :--- | :--- |
| **Left** | `Ctrl + w`, `h` | `Ctrl + w`, `←` |
| **Down** | `Ctrl + w`, `j` | `Ctrl + w`, `↓` |
| **Up** | `Ctrl + w`, `k` | `Ctrl + w`, `↑` |
| **Right** | `Ctrl + w`, `l` | `Ctrl + w`, `→` |

---

## 🌲 File Explorer (nvim-tree)
The explorer is located on the **right** and features relative line numbers for quick navigation within the tree.

### Explorer Internal Commands
| Key | Action |
| :--- | :--- |
| `Enter` | Open file and switch focus to editor. |
| `Tab` | **Preview**: Open file while keeping focus on the tree. |
| `a` | **Add**: Create a new file (or folder if name ends in `/`). |
| `d` | **Delete**: Remove the selected file/folder. |
| `r` | **Rename**: Change file/folder name. |
| `f` | **Filter**: Search for files in the current view. |
| `q` | Close the tree. |

