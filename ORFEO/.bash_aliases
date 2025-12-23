# Bash Aliases

# General aliases
alias c='clear'
alias v='vim'
alias monitor='tail -n +1 -f'
alias mon='tail -n +1 -f'
# also useful: watch -n 1 cat FILE
alias commands='cat $HOME/commands.txt'
alias ff='fastfetch'

# Color support aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
	alias ll='ls -lrt --color=auto'
	alias l='ls -la --color=auto'
	# alias tree='tree --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# SLURM aliases:

# Squeue commands
alias sq='squeue -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R" | grep --color=always "tallone.gvt\|$"'
alias mysq='squeue -u $USER -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R"'
alias sqdgx='squeue -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R" -p DGX'
alias sqepyc='squeue -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R" -p EPYC'
alias sqgpu='squeue -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R" -p GPU'
alias sqthin='squeue -o "%.10i %.9P %.20j %.12u %.10T %.10M %.10L %.6D %R" -p THIN'

# CLuster info commands
alias si="sinfo -lN -p DGX,EPYC,GPU,THIN"
alias sidgx='sinfo -lN -p DGX'
alias siepyc='sinfo -lN -p EPYC'
alias sigpu='sinfo -lN -p GPU'
alias sithin='sinfo -lN -p THIN'

# Jobs History commands: see `sacct --helpformat` for entries
alias myjobs='sacct -u $USER -X -s RUNNING --format="JobID,JobName%25,Partition,Account,AllocCPUS,State,ExitCode,Elapsed,Start,End"'
alias myhist='sacct -u $USER -S 1970-01-01 -X --format="JobID,JobName%25,Partition,Account,AllocCPUS,State,ExitCode,Elapsed,Start,End"'

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

