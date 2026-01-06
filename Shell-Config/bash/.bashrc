# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Cek dulu apakah folder fnm ada, baru jalankan
FNM_PATH="~/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
# --- FNM CONFIGURATION END ---

# Alias to easily start and stop waydroid service

alias wayon="sudo systemctl start waydroid-container && XCURSOR_THEME=Sparkle XCURSOR_SIZE=24 waydroid session start"
alias wayoff="waydroid session stop && sudo systemctl stop waydroid-container"

alias ida='~/.Downloads/AppImage/IDA\ Pro\ 7.6/start_ida.sh'

# ==========================================
# PRODUCTIVITY TOOLS CONFIGURATION
# ==========================================

# --- Starship Prompt ---
eval "$(starship init bash)"

# --- Zoxide (Smart cd) ---
eval "$(zoxide init bash)"
alias cd="z"  # Replace cd with zoxide

# --- FZF (Fuzzy Finder) ---
eval "$(fzf --bash)"

# --- Useful Aliases ---
# bat (better cat)
alias cat="bat --paging=never"
alias catp="bat"  # bat with pager

# ls replacements (using standard ls with colors since eza not available)
alias ll="ls -lah --color=auto"
alias la="ls -A --color=auto"
alias l="ls -CF --color=auto"

# System monitoring
alias top="btop"

# Quick system info
alias sysinfo="fastfetch"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline -10"
alias gd="git diff"

# Navigation shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Safety aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# NVIDIA GPU (if needed)
alias gpu="nvidia-smi"
alias gpu-status="cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status"

# DISTROBOX ALIAS
alias hackbox="distrobox enter hackbox -- bash"

#open fastfetch instanly when new session is init
fastfetch
