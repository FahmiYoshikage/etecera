# 🐚 Shell Configuration Backup

Konfigurasi shell modern untuk Fedora dengan Zsh, Starship, dan berbagai plugin produktivitas.

## 📁 Isi Folder

| File | Deskripsi |
|------|-----------|
| `.zshrc` | Konfigurasi utama Zsh dengan Zinit plugin manager |
| `starship.toml` | Konfigurasi Starship prompt |
| `bashrc.backup` | Backup konfigurasi Bash (opsional) |

---

## 🚀 Cara Install

### 1. Install Dependencies

```bash
# Install zsh dan tools
sudo dnf install -y zsh zoxide fzf bat btop fastfetch

# Install Starship
curl -sS https://starship.rs/install.sh | sh
```

### 2. Copy Konfigurasi

```bash
# Copy .zshrc ke home
cp .zshrc ~/.zshrc

# Copy starship config
mkdir -p ~/.config
cp starship.toml ~/.config/starship.toml
```

### 3. Set Zsh sebagai Default Shell

```bash
sudo chsh -s /usr/bin/zsh $(whoami)
```

### 4. Buka Terminal Baru

Zinit akan otomatis install semua plugin saat pertama kali dijalankan.

---

## 🔌 Plugin yang Terinstall

| Plugin | Fungsi |
|--------|--------|
| `zsh-syntax-highlighting` | Syntax highlighting seperti Fish shell |
| `zsh-autosuggestions` | Saran otomatis berdasarkan history |
| `zsh-completions` | Completion tambahan untuk banyak command |
| `zsh-history-substring-search` | Cari history dengan ↑↓ setelah mengetik |
| `zsh-z` | Jump ke direktori yang sering dikunjungi |
| `zsh-colored-man-pages` | Man pages berwarna |
| `zsh-autopair` | Auto-pair brackets dan quotes |

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Fungsi |
|----------|--------|
| `Ctrl+R` | Fuzzy search history (FZF) |
| `Ctrl+T` | Fuzzy search files (FZF) |
| `↑` / `↓` | Cari history setelah mengetik |
| `Ctrl+→` | Forward word |
| `Ctrl+←` | Backward word |
| `Tab` | Completion dengan menu |

---

## 📝 Aliases yang Tersedia

### Git
```
gs  = git status
ga  = git add
gc  = git commit
gp  = git push
gl  = git log --oneline -10
gd  = git diff
gco = git checkout
gb  = git branch
```

### Navigation
```
..   = cd ..
...  = cd ../..
.... = cd ../../..
```

### System
```
top     = btop
sysinfo = fastfetch
gpu     = nvidia-smi
```

### Utilities
```
cat   = bat (syntax highlighting)
catp  = bat with pager
reload = source ~/.zshrc
zshrc  = edit ~/.zshrc
```

---

## 🎨 Starship Features

Prompt menampilkan:
- 🎩 OS icon (Fedora)
- 📦 Container indicator (distrobox)
- Username@hostname
- Current directory
- 🌿 Git branch & status
- Language versions (Node, Python, Rust, Go, dll)
- ⏱️ Command duration (jika > 2 detik)

---

## 🔧 Troubleshooting

### Plugin tidak terinstall
```bash
# Reinstall zinit
rm -rf ~/.local/share/zinit
source ~/.zshrc
```

### Starship tidak muncul
```bash
# Cek apakah starship terinstall
which starship

# Install ulang jika perlu
curl -sS https://starship.rs/install.sh | sh
```

### Icons tidak muncul
Install Nerd Font:
1. Download dari https://www.nerdfonts.com/font-downloads
2. Pilih JetBrainsMono Nerd Font
3. Extract ke `~/.local/share/fonts/`
4. `fc-cache -fv`
5. Set font terminal ke "JetBrainsMono Nerd Font"

---

## 📅 Info

- **Created**: 2026-01-06
- **Author**: Configured with Antigravity AI
- **Tested on**: Fedora 43 with GNOME
