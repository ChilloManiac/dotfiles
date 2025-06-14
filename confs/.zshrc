# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$HOME/.yarn/bin:$HOME/.local/share/mise/shims:$PATH"

# ZSH settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
COMPLETION_WAITING_DOTS="false"
HIST_STAMPS="dd-mm-yyyy"
zstyle ':completion:*:*:make:*' tag-order 'targets'
zstyle ':completion:*:*:make:*' call-command true 


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
  kubectl
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
# Shell
# =================================
bindkey -v # vi mode
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

GH_PREFIX="IS_GH_CLI=1"
GH_PR_PREFIX="IS_GH_PR=1"
alias gh="$GH_PREFIX gh"
alias ghpc="$GH_PREFIX $GH_PR_PREFIX gh pr create -e"

# Functions
# =================================
function gnb() {
  git fetch -a
  git switch -c $1
  git rebase origin/main --force
}

# Exports
# =================================
export GIT_EDITOR=nvim
export GPG_TTY=$(tty)
export EDITOR=nvim
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH" # image.nvim

# LEGO
# ==========
export EMMA_ENV=dev
export EMMA_DEFAULT_WORKSPACE=139
if [ -f "$HOME/.config/lego/accounts.sh" ]; then
  source "$HOME/.config/lego/accounts.sh"
fi
export EMMA_SKIP_POST_CHECKOUT_INSTALL="true"


# Tools
# =================================
eval "$(zoxide init zsh --cmd cd)" # Install by Mise
eval "$(starship init zsh)" # `cargo install starship --locked`

autoload -U +X bashcompinit && bashcompinit


