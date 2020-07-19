### Prompt ###
#
# Result: '[1] .config ❯❯❯ '
PS1="%(0?..%F{red}[%?]%f )%F{blue}%1~%f %F{red}❯%F{yellow}❯%F{green}❯%f "


### Aliases ###
#
# Colors
alias ls="ls --color=auto"
alias grep="grep --colour=auto"
#
# Options
alias ll="ls -l"
alias la="ls -la"
alias cal="cal -m -3"
alias ssh="TERM=linux ssh"
#
# Backup tools
alias mount_backup="udisksctl mount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 -o compress=lzo"
alias unmount_backup="udisksctl unmount -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2 && udisksctl power-off -b /dev/disk/by-uuid/ddb3a586-36d4-4e3e-889d-7e41f6b407a2"

### Functions ###
#
# Send backup
function send_backup {
    sudo btrfs send -p /.snapshots/"$1" /.snapshots/"$2" | sudo btrfs receive "$3"
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


### Basic autocomplete ###
#
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

### Plugins ###
#
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh


### Change cursor shape for different modes ###
#
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select


### Keys ###
#
# Use vi-like input
bindkey -v
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


### Default cursor ###
#
precmd() { printf '\033]50;CursorShape=1\x7'; }

### Greeting ###
#
uname -r | cut -d '-' -f 1 | figlet -k | lolcat -F .5 $argv;
bindkey -s '^Z' 'lfcd^M'