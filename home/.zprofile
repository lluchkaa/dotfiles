# region homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# endregion

# region variables
export EDITOR="vim"
# endregion

# region completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
# endregion

# region zsh
source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ZVM_CURSOR_STYLE_ENABLED=false
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# endregion

# region fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
eval "$(fzf --zsh)"
# endregion

# region local scripts
export PATH="$PATH:$HOME/.local/scripts/"
alias ts=tmux-sessionizer
# endregion

# region nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
# endregion

# region pnpm
export PNPM_HOME="$HOME/.pnpm"
export PATH="$PATH:$PNPM_HOME"
# endregion

# region go
export GOPATH="$HOME/development/go"
export PATH="$PATH:$(go env GOROOT)/bin:$(go env GOPATH)/bin"
# endregion

# region rust
. "$HOME/.cargo/env"
# endregion

# region ocaml
# [[ ! -r /Users/lluchkaa/.opam/opam-init/init.zsh ]] || source /Users/lluchkaa/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
# endregion

# region dart
# export PATH="$PATH:$HOME/.pub-cache/bin"
# endregion

# region flutter
# export FLUTTER_HOME="$HOME/development/flutter/bin"
# export PATH="$PATH:$FLUTTER_HOME"
# export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
# endregion

# region copilot
alias "??"="gh copilot suggest -t shell"
# endregion
