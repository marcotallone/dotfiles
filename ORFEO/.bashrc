# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Login statement
echo ""
echo "───────────────────────────────────────────────────────"
echo "Welcome $(whoami)!"
echo "You are on node: $(hostname)"
echo "Your.bashrc is being sourced correctly"
echo "───────────────────────────────────────────────────────"
echo ""

# Aliases
if [ -f ~/.bash_aliases ]; then
                source ~/.bash_aliases
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability;
# turned off by default to not distract the user:
# the focus in a terminal window should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
        fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[01;32m\]\u@\h \[\e[01;34m\]\w \$\[\e[00m\] '
else
    PS1='\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/u/dssc/mtallone/scratch/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/u/dssc/mtallone/scratch/miniconda/etc/profile.d/conda.sh" ]; then
#        . "/u/dssc/mtallone/scratch/miniconda/etc/profile.d/conda.sh"
#    else
#        export PATH="/u/dssc/mtallone/scratch/miniconda/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<

