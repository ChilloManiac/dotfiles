# Plugins 
# ================================== 
source <(antibody init)
export ZSH="$(antibody path ohmyzsh/ohmyzsh)"
   
antibody bundle ohmyzsh/ohmyzsh
antibody bundle ohmyzsh/ohmyzsh path:plugins/asdf
antibody bundle ohmyzsh/ohmyzsh path:plugins/docker
antibody bundle ohmyzsh/ohmyzsh path:plugins/fzf
antibody bundle ohmyzsh/ohmyzsh path:plugins/git

antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle dracula/zsh


# 

# Settings
# ================================== 
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd-mm-yyyy"

# Enable vi mode
bindkey -v

bindkey '^R' history-incremental-search-backward

# Misc
# ==================================
autoload bashcompinit 
bashcompinit
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin # Kitty autocomplete
complete -C '/usr/local/bin/aws_completer' aws


# eval "$(fasd --init auto)" #fasd initialized
unsetopt BEEP # remove beeps

# Asdf
# =================================
#. ~/.asdf/plugins/java/set-java-home.zsh
# . ~/.asdf/plugins/dotnet-core/set-dotnet-home.zsh

# Aliases
# =================================
alias vim=nvim
alias c='fasd_cd -d'
alias cc='fasd_cd -d -i'
alias v='f -e nvim'
alias z='f -e zathura'
alias k='kubectl'

# Functions
# =================================
function set-dotnet-vars {
  DOTNET_BASE=$(dotnet --info | grep "Base Path" | awk '{print $3}')
  echo "DOTNET_BASE: ${DOTNET_BASE}"
  
  DOTNET_ROOT=$(echo $DOTNET_BASE | sed -E "s/^(.*)(\/sdk\/[^\/]+\/)$/\1/")
  echo "DOTNET_ROOT: ${DOTNET_ROOT}"
  
  export MSBuildSDKsPath=${DOTNET_BASE}Sdks/ 
  export DOTNET_ROOT=$DOTNET_ROOT
  export PATH=$DOTNET_ROOT:$PATH
}
# Exports
# =================================
export PROFILE=/home/cnor/.zshrc
export STOW_DIR=/home/cnor/stow
export PATH=/home/cnor/.emacs.d/bin/:/home/cnor/.dotnet:/home/cnor/.dotnet/tools:/home/cnor/.asdf/installs/nodejs/16.0.0/.npm/bin:$PATH
# export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export XSECURELOCK_COMPOSITE_OBSCURER=0
export GIT_EDITOR=nvim
export GPG_TTY=$(tty)

source <(kubectl completion zsh)


PATH="/home/cnor/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/cnor/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/cnor/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/cnor/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/cnor/perl5"; export PERL_MM_OPT;
