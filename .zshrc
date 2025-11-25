fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

setopt NO_BEEP
setopt AUTO_CD
setopt CORRECT

bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

# ---------------------------------------
# 🌍 Environment
# ---------------------------------------
export EDITOR="nano"
export VISUAL="$EDITOR"
export PATH="$HOME/.local/bin:$PATH"

export CLICOLOR=1

source <(fzf --zsh)
eval "$(zoxide init zsh --cmd cd)"

# Clear + exit
alias cls='clear'
alias e='exit'

# Git shortcuts
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gp='git push'
alias gpl='git pull'
source ~/themes/powerlevel10k/powerlevel10k.zsh-theme

alias vim='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
