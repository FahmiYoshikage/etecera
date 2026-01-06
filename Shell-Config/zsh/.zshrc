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

# Fast directory jumping
zinit light agkozak/zsh-z

# Colored man pages
zinit light ael-code/zsh-colored-man-pages

# Auto-pair brackets, quotes
zinit light hlissner/zsh-autopair

# Better directory listing with icons
zinit light supercrabtree/k

# Git status in prompt additions
zinit light woefe/git-prompt.zsh

# --- Snippets (useful OMZ plugins without full OMZ) ---
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::extract
zinit snippet OMZP::cp

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

# --- Useful Options ---
setopt AUTO_CD              # cd without typing cd
setopt AUTO_PUSHD           # Push directories to stack
setopt PUSHD_IGNORE_DUPS    # Ignore duplicate directories
setopt CORRECT              # Command correction
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell
setopt NO_BEEP              # No beep sound

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

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# GPU monitoring
alias gpu='nvidia-smi'
alias gpu-status='cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status'

# Distrobox
alias hackbox='distrobox enter hackbox -- bash'

# Quick edit configs
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias reload='source ~/.zshrc'

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
