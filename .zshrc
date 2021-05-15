export ZSH=/Users/alan/.oh-my-zsh # Path to oh-my-zsh installation.
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
  jump
  git
  z
)
ZSH_THEME="common"
CASE_SENSITIVE="true"             # Case sensitive completion
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
# Swap FZF find for fd, don't ignore hidden
export FZF_DEFAULT_COMMAND='fd --type file --type directory --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# For React-Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# LaTeX
export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:$PATH"

# https://www.atlassian.com/git/tutorials/dotfiles
alias dconf='/usr/local/bin/git --git-dir=$HOME/.configs/ --work-tree=$HOME'
alias history='history -E'
alias notebook='jupyter notebook'
alias e='exa'
alias ea='exa -la --icons --git'
alias v='vim'
alias nv="/Users/alan/nvim-osx64/bin/nvim"
alias j="jump"
alias jm="mark"
alias ju="unmark"

path+=('/usr/local/mysql/bin')
path+=('~/anaconda3/bin')


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/alan/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/alan/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alan/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/alan/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate newds

# Function to ssh and start notebook on pink.local default port 6969
pink(){
  if [ -z "$1" ]
  then 
    ssh pink.local -L 6969:localhost:6969
  else
    ssh pink.local -L $1\:localhost:$1
  fi
}

# FZF autcompletion and shortcuts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
