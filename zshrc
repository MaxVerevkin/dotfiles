### Colors ###

# [1] .config ❯❯❯ command            (master|✚1)
source ~/.zsh/zsh-git-prompt/zshrc.sh
PS1="%(0?..%F{red}[%?]%f )%F{blue}%1~%f %F{red}❯%F{yellow}❯%F{green}❯%f "
RPS1='$(git_super_status)'

### Aliases ###
#
# Verbose
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
#
# Shortcuts
alias sudo="sudo "
alias vi="nvim"
alias sbfs="sudo btrfs"
#
# Colors
alias ls="ls --color=auto"
alias grep="grep --colour=auto"
#
# ls
alias ls="exa"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
# Options
alias cal="cal -m"
alias ssh="TERM=linux ssh"
alias make="make -j3"
alias sympy="python -i -c \"from sympy import *\""


### Functions ###
#
function kpatch () {
  patch=$1
  shift
  git send-email \
    --cc-cmd="./scripts/get_maintainer.pl --norolestats $patch" \
    $@ $patch
}

#
# Share screen
function share_screen() {
    wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video4 -x yuv420p
}
#
# Statistics
function hist_stat {
    history -1000000 | awk '{print $2}' | sort | uniq -c | sort -nr | less
}
#
# Ctreate snapshot
function make_snap {
    last_snap_full=$(ls -1 /.snapshots | sort | tail -n1)
    last_snap_date=$(echo $last_snap_full | cut -d'#' -f1)
    last_snap_has_index=$(echo $last_snap_full | grep '#')
    last_snap_index=$(echo $last_snap_full | cut -d'#' -f2)
    today=$(date "+%Y-%m-%d")
    if [ $last_snap_date = $today ]; then 
        if [ -z $last_snap_has_index ]; then
            sudo btrfs subvolume snapshot -r / /.snapshots/$today#2
        else
            index=$(($last_snap_index + 1))
            sudo btrfs subvolume snapshot -r / /.snapshots/$today#$index
        fi
    else
        sudo btrfs subvolume snapshot -r / /.snapshots/$today
    fi
}
#
# lfcd
function lfcd {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && cd "$dir"
    fi
}

### History stuff ###
#
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh/.zhistory
setopt hist_ignore_all_dups
#setopt hist_ignore_space
setopt share_history
setopt histignorespace


### Basic autocomplete ###
#
# Init
autoload -U compinit && compinit
zmodload zsh/complist
setopt correct
setopt autocd
#
# Style
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors '=(#b)*(-- *)=36=93' '=*=36'
#zstyle ':completion:::::' completer _complete _approximate
#zstyle ':completion:*:approximate:*' max-errors 1
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d --- %b"
zstyle ':completion:*' group-name ''

### Plugins ###
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


### Keys ###
#
# Use vi-like input
bindkey -e
#
# TTY sends different key codes. Translate them to regular.
bindkey -s '^[[1~' '^[[H'  # home
bindkey -s '^[[4~' '^[[F'  # end
#
# Make PgUp and PgDown the same as Up and Down
bindkey -s "^[[6~" "^[[B"
bindkey -s "^[[5~" "^[[A"
#
# Bindings
bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
#bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
#bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word
#bindkey '^J'      backward-kill-line            # ctrl+j     delete everything before cursor
bindkey '^[[D'    backward-char                 # left       move cursor one char backward
bindkey '^[[C'    forward-char                  # right      move cursor one char forward
bindkey '^[[A'    history-substring-search-up   # up         prev command in history
bindkey '^[[B'    history-substring-search-down # down       next command in history
bindkey -s '^Z' 'lfcd^M'


### Default cursor ###
#
precmd() { printf '\e[5 q'; }
