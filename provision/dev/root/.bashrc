if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[[ -s "/etc/grc.bashrc" ]] && source /etc/grc.bashrc
