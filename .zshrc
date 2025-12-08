# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
# check for. sudo aws command-not-found

autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#bindkey '^n' autosuggest-accept
# emacs mode
# - Ctrl+f (accept autosuggestion)
# - Ctrl+b (going backward in prompt on char at time)
# - Ctrl+f (going forward)
# - Ctrl+a (start of line)
# - Ctrl+e (end of line)
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt=appendhistory
setopt=sharehistory
setopt=hist_ignore_space
setopt=hist_ignore_all_dups
setopt=hist_save_no_dups
setopt=hist_ignore_dups
setopt=hist_find_no_dups

# copmletino styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags '--height=70%'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# interesting
#zstyle ':fzf-tab:complete:bat:*' fzf-preview --height=10 '[[ -d "$realpath" ]] && ls --color "$realpath" || bat --style=numbers --color=always "$realpath"'

# fzf search
# Ctrl+r (do search)
# Ctrl+p (previous in list)
# Ctrl+n (next in list)
eval "$(fzf --zsh)"

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GO=/usr/bin/go
export GO111MODULE=on
export VISUAL="nvim"
export GIT_EDITOR=nvim

# Load environment variables and secrets (not tracked in git)
[[ -f ~/.zsh.env ]] && source ~/.zsh.env

export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=20480
export MAX_THINKING_TOKENS=1024

#export ANTHROPIC_MODEL='us.anthropic.claude-opus-4-1-20250805-v1:0'
export ANTHROPIC_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0'
export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'

export PATH=/opt/homebrew/bin:$GOBIN:$PATH

alias du="du -sh"
alias df="df -h"
alias la='lsd -al'
alias v='nvim'
alias zs='source ~/.zshrc'
alias c='clear'
alias nf='clear && fastfetch'

#pulumi
alias pss="pulumi stack select"
alias psr="pulumi stack rm"
alias psi="pulumi stack init"
alias pp="pulumi preview"
alias pu="pulumi up"
alias pd="pulumi destroy"
alias ppi="pulumi package info ."
alias ppp="pulumi package publish"
alias pi="pulumi install"
alias pr="pulumi refresh"
alias put="pulumi-update-template"
alias bu="brew update && brew upgrade --greedy && brew autoremove && brew cleanup" # && mas upgrade"


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Initialize zoxide (must be at the end)
eval "$(zoxide init --cmd cd zsh)"
