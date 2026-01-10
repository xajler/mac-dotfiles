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

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

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
bindkey '\e.' insert-last-word  # Alt+. to insert last argument
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line  # Ctrl+x Ctrl+e to edit command in $EDITOR

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# copmletino styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':fzf-tab:*' fzf-flags '--height=70%'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

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

# Load private aliases, settings, and secrets (not tracked in git)
[[ -f ~/.zsh.env ]] && source ~/.zsh.env

export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=20480
export MAX_THINKING_TOKENS=1024

#export ANTHROPIC_MODEL=us.anthropic.claude-opus-4-5-20251101-v1:0
export ANTHROPIC_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0'
export ANTHROPIC_SMALL_FAST_MODEL=us.anthropic.claude-haiku-4-5-20251001-v1:0
#export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'

export PATH=/opt/homebrew/bin:$GOBIN:$PATH

alias du="du -sh"
alias df="df -h"
alias v='nvim'
alias zs='source ~/.zshrc'
alias c='clear'
alias nf='clear && fastfetch'

# git
alias gst='git status -sb'
alias glog='git log --oneline --decorate --graph --all'
alias gundo='git reset --soft HEAD~1'

# modern cli tools
alias cat='bat --style=plain'
alias ls='eza --icons --git --ignore-glob=".DS_Store"'
alias ll='eza -l --icons --git --ignore-glob=".DS_Store"'
alias la='eza -la --icons --git --ignore-glob=".DS_Store"'

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
alias bu="brew update && brew upgrade --greedy && brew autoremove && brew cleanup && brew services restart sketchybar" # && mas upgrade"


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Initialize direnv
eval "$(direnv hook zsh)"

# Initialize atuin (advanced shell history)
eval "$(atuin init zsh)"

# Zellij session manager
zm() {
  if [ $1 ]; then
    local session_name="$1"
    local start_dir="${2:-$PWD}"  # Use provided dir or current dir

    # Change to the target directory first
    builtin cd "$start_dir"

    # Attach to session (creates if doesn't exist)
    zellij attach --create "$session_name"
    return
  fi
  # Interactive session picker with fzf
  session=$(zellij list-sessions 2>/dev/null | fzf --exit-0) && zellij attach "$session" || echo "No sessions found."
}

# Quick project session aliases
alias tmd='zm dotfiles ~'
alias tml='zellij list-sessions'
alias tmk='zellij delete-session'  # Kill session: tmk session-name

# Claude Code with Opus 4.5 (Bedrock)
alias cm='claude --model us.anthropic.claude-opus-4-5-20251101-v1:0'

# Initialize zoxide (must be at the end)
# Use 'z' command instead of overriding 'cd' to avoid issues with non-zsh contexts
eval "$(zoxide init zsh)"

# Alias for zoxide interactive picker (zi conflicts with zinit)
alias zz='__zoxide_zi'
