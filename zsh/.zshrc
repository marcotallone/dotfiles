# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ #
# ┃                               ZSHRC FILE                                ┃ #
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ #
# ZSHELL CONFIGURATION FILE
# Marco Tallone
# 12/02/2025

# INFO: Dotfiles:					https://github.com/marcotallone/dotfiles

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │																	Aliases 																│ #
# └─────────────────────────────────────────────────────────────────────────┘ #
# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source the aliases file
# (in case you want to store them in a separate file)
# if [ -f ~/.zsh_aliases ]; then
# 		source ~/.zsh_aliases
# fi

# General
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias shutdown='systemctl poweroff'
alias wifi='nmtui'

# Editor
alias n='$EDITOR'
alias v='vim'
# alias vim='$EDITOR'

# Dotfiles
# alias ts='~/dotfiles/scripts/snapshot.sh'
alias dot="cd ~/dotfiles && nvim ."
alias zrc="nvim ~/.zshrc"
alias zalias="nvim ~/.zsh_aliases"
# alias cleanup='~/dotfiles/scripts/cleanup.sh'

# Aliases for ls (eza)
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias tree="eza --tree"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# Aliases for cat (batcat)
# if command -v bat > /dev/null; then
# 	alias cat="bat"
# elif command -v batcat > /dev/null; then
# 	alias cat="batcat"
# fi

# Kubernetes
alias k="kubectl"
alias kpod="kubectl get pods"
alias ksvc="kubectl get svc"
alias kd="kubectl describe"

# Tmux
alias t="tmux"
alias ta="tmux attach"
alias tls="tmux ls"
alias ts="tmux new-session"

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │																PowerLevel10k															│ #
# └─────────────────────────────────────────────────────────────────────────┘ #
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │																	Oh My Zsh																│ #
# └─────────────────────────────────────────────────────────────────────────┘ #
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │										User Preferences and Configuration										│ #
# └─────────────────────────────────────────────────────────────────────────┘ #

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Enable fzf
source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

# Zoxide
eval "$(zoxide init zsh)"

# Open pdf function with zathura & disown
open(){
	zathura $1 & disown
}

# Vagrant Docker container for libvirt (function)
# vagrant(){
#   docker run -it --rm \
# 		--privileged \
# 		-e LIBVIRT_DEFAULT_URI="qemu:///system" \
#     -v /var/run/libvirt/:/var/run/libvirt/ \
#     -v ~/.vagrant.d:/.vagrant.d \
#     -v $(realpath "${PWD}"):${PWD} \
#     -w "${PWD}" \
#     --network host \
#     vagrantlibvirt/vagrant-libvirt:latest \
#       vagrant $@
# }
# export KUBECONFIG=/home/marco/.kube/config.demo

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │															 Path Variables															│ #
# └─────────────────────────────────────────────────────────────────────────┘ #

# ???
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Cargo path for Rust
export PATH=$PATH:/home/marco/.cargo/bin

# ┌─────────────────────────────────────────────────────────────────────────┐	#
# │																	 Conda	  															│ #
# └─────────────────────────────────────────────────────────────────────────┘ #
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/marco/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/marco/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/marco/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/marco/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
