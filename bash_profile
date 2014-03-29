source ~/.profile

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

alias ls='ls -GlFh'
alias lsa='ls -a'
alias header='curl -I --compress'
alias headers='curl -I --compress'

alias slt='open -a "Sublime Text"'
alias vgb='cd ~/Vagrant\ Boxes'
alias dev='cd ~/Development'
alias his='history'

# Creates a new file and opens it in sublime text.
# Usage: "sltn my_file.ext"
function sltn() { touch $@; slt $@; }
function gi() { curl http://gitignore.io/api/$@ ;}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# MacPorts Installer addition on 2014-03-24_at_16:09:18: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

