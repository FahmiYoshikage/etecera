# ============================================
# ZSH Configuration - Modern & Feature-Rich
# ============================================

# --- Zinit Plugin Manager ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{33}▓▒░ Installing Zinit...%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{34}▓▒░ Zinit installed!%f" || \
        print -P "%F{160}▓▒░ Clone failed%f"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- Essential Plugins ---

# Syntax Highlighting (like Fish shell)
zinit light zsh-users/zsh-syntax-highlighting

# Auto-suggestions based on history
zinit light zsh-users/zsh-autosuggestions

# Better completions
zinit light zsh-users/zsh-completions

# Substring history search (type and press up arrow)
zinit light zsh-users/zsh-history-substring-search

# Colored man pages
zinit light ael-code/zsh-colored-man-pages

# Auto-pair brackets, quotes
zinit light hlissner/zsh-autopair

# --- Snippets (useful OMZ plugins without full OMZ) ---
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::extract

# --- Completions ---
autoload -Uz compinit
compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'

# --- History Settings ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# --- Key Bindings ---
bindkey -e  # Emacs mode
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Ctrl+Z toggle suspend/resume
fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# --- Useful Options ---
setopt AUTO_CD              # cd without typing cd
setopt AUTO_PUSHD           # Push directories to stack
setopt PUSHD_IGNORE_DUPS    # Ignore duplicate directories
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell
setopt NO_BEEP              # No beep sound

# --- Environment Variables ---
export EDITOR='nano'
export VISUAL='code'
export LESS='-R'

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- Zoxide (Smart cd) ---
eval "$(zoxide init zsh)"

# --- FZF (Fuzzy Finder) ---
eval "$(fzf --zsh)"

# FZF Configuration for better looks
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || cat {}'
  --preview-window=right:50%:wrap
"

# --- Aliases ---

# Better ls with colors
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# bat (better cat)
alias cat='bat --paging=never'
alias catp='bat'

# System monitoring
alias top='btop'
alias sysinfo='fastfetch'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'


# GPU monitoring
alias gpu='nvidia-smi'
alias gpu-status='cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status'

# Distrobox
alias hackbox='distrobox enter hackbox -- bash'

# Quick edit configs
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias reload='source ~/.zshrc'

# Search & Utility
alias ff='find . -name'               # ff "*.txt"
alias grep='grep --color=auto'
alias serve='python3 -m http.server'  # Quick web server

# Clipboard (WSL)
alias copy='clip.exe'
alias paste='powershell.exe Get-Clipboard'

# Disk usage
alias df='df -h'
alias du='du -h'
alias duf='du -sh * | sort -h'

# --- Useful Functions ---

# Buat folder dan langsung masuk
mkcd() { mkdir -p "$1" && cd "$1" }

# Extract dengan auto-detect
ex() {
  case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz)  tar xzf $1 ;;
    *.tar.xz)  tar xJf $1 ;;
    *.zip)     unzip $1 ;;
    *.7z)      7z x $1 ;;
    *.rar)     unrar x $1 ;;
    *)         echo "Unknown format: $1" ;;
  esac
}

# Backup file dengan timestamp
backup() { cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)" }

# --- FNM (Fast Node Manager) ---
FNM_PATH="/home/fahmi/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="$FNM_PATH:$PATH"
    eval "$(fnm env)"
fi

# --- Waydroid aliases ---
alias wayon="sudo systemctl start waydroid-container && XCURSOR_THEME=Sparkle XCURSOR_SIZE=24 waydroid session start"
alias wayoff="waydroid session stop && sudo systemctl stop waydroid-container"

# --- IDA Pro ---
alias ida='/home/fahmi/Downloads/AppImage/IDA\ Pro\ 7.6/start_ida.sh'

# ============================================
# Welcome Message
# ============================================
if [[ -o interactive ]]; then
    fastfetch 2>/dev/null || echo "Welcome to ZSH!"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2026-01-08 04:42:16
export PATH="$PATH:/home/fahmi/.local/bin"


sudo dnf update -y && sudo dnf upgrade -y
