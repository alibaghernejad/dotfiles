#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# human readable list with colors.
alias ls='ls  --color=auto' 
alias ldot='ls -ld .*'
alias ll='ls -latr'
alias lsr='ls -lARFh' #Recursive list of files and directories

alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


#=============== Environment Variables ===============

# Enable vim key bindings for terminal.
set -o vi 

#=============== Aliases ===============

alias opn='xdg-open'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
# Commiting only specified part of files or breaking lange commit into smaller parts.
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gst='git status'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gamscp='git am --show-current-patch'
alias gams='git am --skip'
alias gap='git apply'
alias gapt='git apply --3way'
alias gbs='git bisect'
alias gbss='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias aqu='asciiquarium'

# dotfiles shortkey
alias dot='cd ~/dotfiles'

# Zettelkasten shortkey
alias zk='cd ~/Zettelkasten'

# NeoVim Shortkey
alias v='nvim'

mcd () {
    mkdir -p $1
    cd $1
}

alias ads='exec /opt/azure-data-studio/bin/azuredatastudio "$@" $ADS_USER_FLAGS'

# source fzf bindings into the shell emulator
source <(fzf --bash)

function ext {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}
