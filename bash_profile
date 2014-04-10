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

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

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

