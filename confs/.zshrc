# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$HOME/.yarn/bin:$HOME/.local/share/mise/shims:$PATH"

# ZSH settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
COMPLETION_WAITING_DOTS="false"
HIST_STAMPS="dd-mm-yyyy"


# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  gh
  git
  fzf
  docker
  rust
  terraform
  mise
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
# Shell
# =================================
bindkey -v # vi mode
bindkey '^R' history-incremental-search-backward
autoload bashcompinit
bashcompinit
autoload -Uz compinit
compinit
unsetopt BEEP # remove beeps

complete -C aws_completer aws

# Aliases
# =================================
alias vim=nvim
alias k='kubectl'

GH_PREFIX="IS_GH_CLI=1 gh"
alias gh="$GH_PREFIX"


# Exports
# =================================
export GIT_EDITOR=nvim
export GPG_TTY=$(tty)
export EDITOR=nvim

# LEGO
# ==========
export EMMA_ENV=dev
export EMMA_DEFAULT_WORKSPACE=139
if [ -f "$HOME/.config/lego/accounts.sh" ]; then
  source "$HOME/.config/lego/accounts.sh"
fi


# Tools
# =================================
eval "$(zoxide init zsh --cmd cd)" # Install by Mise
eval "$(starship init zsh)" # `cargo install starship --locked`

autoload -U +X bashcompinit && bashcompinit
