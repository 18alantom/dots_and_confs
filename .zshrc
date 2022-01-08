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
CASE_SENSITIVE="true"
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export NVM_DIR="$HOME/.nvm"
# Swap FZF find for fd, don't ignore hidden
export FZF_DEFAULT_COMMAND='fd --type file --type directory --hidden --exclude node_modules --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ref: atlassian.com/git/tutorials/dotfiles
alias dconf='/usr/bin/git --git-dir=$HOME/.dots_and_confs/ --work-tree=$HOME'
alias history='history -E'
alias nb='jupyter notebook'
alias e='exa'
alias ea='exa -la --icons --git'
alias v='vim'
alias nv="nvim"
alias j="jump"
alias jm="mark"
alias ju="unmark"
alias dh="du -hd 1"

path+=('~/anaconda3/bin')

# FZF autcompletion and shortcuts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


init_conda() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  conda activate main
}

init_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# ref: gist.github.com/QinMing/364774610afc0e06cc223b467abe83c0
lazy_load() {
  local -a names
  names=("${(@s: :)${1}}") # split $1 by space
  unalias "${names[@]}"
  $2
  unset -f $2
  shift 2
  $*
}

group_lazy_load() {
  local script
  script=$1
  shift 1
  for cmd in "$@"; do
    alias $cmd="lazy_load \"$*\" $script $cmd"
  done
}

group_lazy_load init_nvm code nvm node npm yarn
group_lazy_load init_conda code py python conda
unset -f group_lazy_load
