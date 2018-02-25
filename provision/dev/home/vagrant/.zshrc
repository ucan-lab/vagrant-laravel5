#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
export LESS='-R'
export LESSOPEN='| $HOME/bin/src-hilite-lesspipe.sh %s'
export GREP_OPTIONS='--color=auto'
export PATH=~/.npm-global/bin:$PATH
