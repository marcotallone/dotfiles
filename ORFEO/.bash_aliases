# Bash Aliases

# General aliases
alias c='clear'
alias v='vim'
alias monitor='tail -n +1 -f'

# Color support aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
        alias ll='ls -lrt --color=auto'
        alias l='ls -la --color=auto'
        alias tree='tree --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# SLURM aliases
alias sinfo="sinfo -lN"
alias mysq="squeue | grep $(whoami)"
alias myjobs="sacct -u $(whoami) -o jobid,jobname,partition,account,alloccpus,state,exitcode,elapsed" # see `sacct --helpformat` for entries
alias sq='squeue | grep --color=always "mtallone\|$"'

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gr="git restore"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

