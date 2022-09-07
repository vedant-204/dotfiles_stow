# _________  _   _
#|__  / ___|| | | |
#  / /\___ \| |_| |
# / /_ ___) |  _  |
#/____|____/|_| |_|
# by - vedant

autoload -Uz compinit
compinit
#export JAVA_HOME="$HOME/Desktop/android-studio/jre/"
#export PATH=$JAVA_HOME/bin:$PATH 
#export PATH="$PATH:/home/kshgrk/Documents/flutter/bin"
#export PATH="$PATH:/home/kshgrk/Documents/flutter/bin/cache/dart-sdk"
#export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin"
#export CHROME_EXECUTABLE='/usr/bin/google-chrome-stable'
#export PATH="$HOME/.emacs.d/bin:$PATH"
# export ANDROID_SDK= '$HOME/Android/Sdk'
# export PATH=$PATH:$ANDROID_SDK/tools/bin/
# export PATH=$PATH:$ANDROID/emulator
# export PATH=$PATH:$ANDROID_SDK/tools/
export EDITOR=nvim
# Set $PATH if ~/.local/bin exist
#if [ -d "$HOME/.local/bin" ]; then
#    export PATH=$HOME/.local/bin:$PATH
#fi

if [ -d "$HOME/.local/lib" ]; then
    export PATH=$HOME/.local/lib:$PATH
fi

# PS1='%F{green}%f%F{blue}%1~%f%F{green}%f$vcs_info_msg_0_ %F{magenta} %f '
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
function set_win_title(){
    echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}
precmd_functions+=(set_win_title)

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source <(kubectl completion zsh)
# Use profiles
#source ~/.profile

# Use fzf
#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh
#source ~/github/fzf-tab/fzf-tab.plugin.zsh
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

## Options section
unsetopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
#
# zstyle ':completion:*:descriptions' format '%U[%d]%u'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000


## Keys
# Use emacs key bindings
bindkey -v

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first' # preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.="exa -a | egrep '^\.'"
alias la='(exa -ahl --color=always --group-directories-first) | bat ' # my preferred listing
alias lr='(exa -aR --color=always --group-directories-first) |bat '  # all files and dirs
alias l='(exa -a --color=always --group-directories-first) |bat '  # all files and dirs
alias ld='(exa -l --color=always --group-directories-first) | bat'  # long format
alias kc='kubectl'

# Common use aliases
alias pd="cd project-management-webapp && code ."
alias cd="z"
alias pwd="pwd | xclip -selection clipboard"
alias k8book='devour zathura ~/Downloads/k8book.pdf'
alias reactprac='cd ~/Desktop/DEV/webd/react && code .'
alias ap='absolutely-proprietary'
alias man-emmet='docs ~/Documents/cheatsheet-a5.pdf'
alias dog='cat'
alias dot='cd ~/.config && nvim'
alias minecraft='java -jar ~/Documents/TLauncher-2.841.jar'
alias mpv="devour mpv"
alias course="dev && cd imp-docs"
alias myweb="cd Desktop/DEV/webd/vedant-website && code ."
alias leet="dev && cd DSA/leetcode"
alias dsprac="dev && cd DSA/DSA-self-prac"
alias vedant="cd ~/"
alias docs="devour zathura"
alias dev="cd ~/Desktop/DEV && nvim"
alias sleep="systemctl suspend"
alias shutdown="sudo shutdown now"
alias reboot="sudo reboot now"
alias aup="pamac upgrade --aur"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias devr='docs ~/Desktop/DEV/imp-docs/2.png'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cod='cd ~/Media/Linux/Buffer/coding && clear'
alias c='clear'
alias e='exit'
alias h='htop'
alias p='pfetch'
alias s='sensors'
alias b='bpytop'
alias t='tmux new-session \; send-keys 'cod' C-m \; splitw -hp 40 \; send-keys 'cod' C-m'
# alias spr="command curl -fsLF 'sprunge=<-' http://sprunge.us"
alias P='sudo powertop'
alias cc='sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"'
alias bb='sudo sh -c "echo 2 > /proc/sys/vm/drop_caches"'
alias cb='sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"'
alias gst='git status'
alias gc='git commit'
alias ga='git add .'
alias gps='git push'
alias gpl='git pull'
alias gph='git log --graph --oneline --all'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
alias nv='nvim' 
alias ryzenadj='sudo ryzenadj'
alias sq='sudo mysql -u root'
alias wall='feh --bg-scale --no-fehbg --random'
alias code='devour code .'
alias sz='du -sh ./* | sort -h'
alias makecfile='echo "#include <stdio.h>\n#include <stdlib.h>\n\n\nint main(){\n}" >> '
alias makecppfile='echo "#include <stdio.h>\n#include <stdlib.h>\n#include <iostream>\n#include <bits/stdc++.h>\n\nint main(){\n}" >> '

# Functions
ushort(){
  curl -F 'shorten='$1'' https://0x0.st
}

ufile(){
  curl -F 'file='$1'' https://0x0.st
}

ushareg(){
  curl -F 'url='$1'' https://0x0.st
}

spr (){
    cat "$@" \
    | command curl -fsLF 'sprunge=<-' http://sprunge.us/ \
    | tr -d "\n" \
    | xclip -in -sel clip && \
    notify-send -t 900 -u low "Sprunge copied to clipboard!"
}

em (){
  devour emacsclient -cq $1
}

iso (){
  sudo dd bs=4M if=$1 of=/dev/$2 status=progress && sync
}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


num(){
  ls -l $1 | wc -l
}

# Get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age" 

# Replace yay with paru if installed
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

alias yayup='sudo pacman -Sy && sudo powerpill -Su && paru -Su'

# Set your countries like --country France --country Germany -- or more.
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && sudo updatedb'

alias cleanup='yay -Rns $(yay -Qtdq)'
## Run paleofetch
#paleofetch

# Then load url-quote-magic and bracketed-paste-magic as above
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Now the fix, setup these two hooks:
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic 
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# and finally, make sure zsh-autosuggestions does not interfere with it:
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# eval "$(ssh-agent -s)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:nohidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
"
