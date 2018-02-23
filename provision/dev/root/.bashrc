if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[[ -s "/etc/grc.bashrc" ]] && source /etc/grc.bashrc
export LESS='-R'
export LESSOPEN='| $HOME/bin/src-hilite-lesspipe.sh %s'
export GREP_OPTIONS='--color=auto'
