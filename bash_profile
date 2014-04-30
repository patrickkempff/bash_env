# ---------------------------------------------------------------------------
# Author: Patrick Kempff <patrickkempff@gmail.com>
# Date: 29 March 2014

# Special thanks to: 

#    Nathaniel Landau, http://natelandau.com/
#    Alias, http://alias.sh/

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ---------------------------------------------------------------------------

# ///////////////////////////////////////////////////////////////////////////
# Configuration
# ///////////////////////////////////////////////////////////////////////////

# export PS1="________________________________________________________________________________\n| \[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] \n| => "
# export PS2="| => "

# Test if user is root and set user color appropriately
if [[ $(id -u) == 0 ]]
then
    export PS1USERCOLOR="\[\033[31m\]"
else
    export PS1USERCOLOR="\[\033[36m\]"
fi

export PS1="$PS1USERCOLOR\u\[\033[m\]@\[\033[32m\]\h\[\033[m\]:\[\033[33;1m\]\w\`if type parse_git_branch > /dev/null 2>&1; then parse_git_branch; fi\`\`if [ \$? = 0 ]; then echo -e '\[\033[m\]\$'; else echo -e '\[\e[31m\]\$'; fi\` \[\033[m\]"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Environment variables to set prompt format and color 
export COLOR_BOLD="\[\e[1m\]"
export COLOR_DEFAULT="\[\e[0m\]"

# Add colors to grep
# export GREP_OPTIONS='–color=auto'
# export GREP_COLOR='1;35;40'

# Set default blocksize, get consistent output across "du", "df", and "ls -s".
export BLOCKSIZE=1k

# Set the default editor to Nano.
export EDITOR=/usr/bin/nano

export HISTCONTROL=erasedups
export HISTSIZE=10000

export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# ///////////////////////////////////////////////////////////////////////////
# Aliases
# ///////////////////////////////////////////////////////////////////////////

# Preferred implementations

alias cp='cp -iv'
alias mv='mv -iv'
alias ls='ls -GlFh'
alias la='ls -Ap'

# Filesystem

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

alias make1mb='mkfile 1m ./1MB.dat'         # Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # Creates a file of 10mb size (all zeros)
alias make100mb='mkfile 100m ./100MB.dat'   # Creates a file of 100mb size (all zeros)
alias make1gb='mkfile 1000m ./1GB.dat'      # Creates a file of 1gb size (all zeros)

alias vgb='cd ~/Vagrant\ Boxes'
alias dev='cd ~/Development'

# Removes all .DS_Store files.
alias remove_ds="find . -type f -name '*.DS_Store' -ls -delete"

# Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

alias paths='echo -e ${PATH//:/\\n}'    	# Echo all executable Paths

# Networking

alias header='curl -I --compress'			# View the response headers of a given URL
alias headers='curl -I --compress'			# View the response headers of a given URL
alias myip='curl ip.appspot.com'            # Public facing IP Address
alias connections='lsof -i'  				# Show all open TCP/IP sockets
alias flush_dns='dscacheutil -flushcache'   # Flush out the DNS Cache

# Decode a url
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

# Git

# Nice git log
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gll="git log --graph --full-history --all --color"

# View git repository online.
github(){
    URL=$(git remote -v | grep github.com | grep fetch | head -1 | awk '{print $2}' | sed 's/git:/http:/g')
    echo "Opening GitHub repository: ${URL}"
    open "${URL}"
}

beanstalk(){
    URL=$(git remote -v | grep beanstalkapp.com | grep fetch | head -1 | awk '{print $2}' |  sed 's/\/.*\///g' | sed 's/:/\//g' | sed 's/git@/http:\/\//g'  | sed 's/.git//g')
    echo "Opening Beanstalkapp repository: ${URL}"
    open "${URL}"
}

function repo () {
    REPO=$(git remote -v | grep github.com | grep fetch | head -1)

    if [ "${REPO}" == "" ]
    then
        beanstalk
    else
        github
    fi
}


# Applications

alias f='open -a "Finder" ./' 				# Open current folder in Finder
alias slt='open -a "Sublime Text"'  		# Open given file in Sublime Text.

# Open the iOS Simulator
alias ios="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"

alias bash_profile_update='curl -s https://raw.githubusercontent.com/websdesign/bash_profile/master/install.sh | bash'


# ///////////////////////////////////////////////////////////////////////////
# Methods
# ///////////////////////////////////////////////////////////////////////////

# Create a new file and open it in Sublime Text.
function sltn() { touch $@; slt $@; }

# Always list directory contents upon 'cd'
# function cd() { builtin cd "$@"; la; }  

# Make a new directory and cd inside
function mcd () { mkdir -p "$1" && cd "$1"; }

# Move a file to the trash.
function trash () { command mv "$@" ~/.Trash ; } 

# Generate a salt with a given length.
salt(){
    if [[ $# == 0 ]]; then
        openssl rand -base64 32
    else
        openssl rand -base64 $1
    fi
}

password(){
    dd if=/dev/random bs=16 count=1 2>/dev/null | base64 | sed 's/=//g'
}

# Generate a random password
alias password='dd if=/dev/random bs=16 count=1 2>/dev/null | base64 | sed 's/=//g''


# Cd to the current Finder folder.
function cdf () {
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

serve(){
    python -m SimpleHTTPServer 9005
    open "http://0.0.0.0:9005"
}

# get current branch in git repo
function parse_git_branch() {
        BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=$(parse_git_dirty)
                echo " [${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

# get current status of git repo
function parse_git_dirty {
        status=$(git status 2>&1 | tee)
        dirty=$(echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")
        untracked=$(echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")
        ahead=$(echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")
        newfile=$(echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")
        renamed=$(echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")
        deleted=$(echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}

