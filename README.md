# Bash Environment

bash_env is a modulair collection of config, aliases and scripts for bash.
It enables colors and introduces handy custom commands to your terminal.

## Gettings started

To install, just paste this into the terminal:

	curl -sSL https://raw.githubusercontent.com/patrickkempff/bash_profile/master/install.sh | bash

Once the profile has been installed, you can update it by typing the following command:

	bash_profile_update

## Extensions

By default bash_env ships with the following extensions:

- [extensions/profile](#profile)
- [extensions/devenv](#devenv)
- [extensions/finder](#finder) (macOS only)
- [extensions/git](#git)

To enable/disable certain extensions take a look at the [enabled.conf](enabled.conf) file.

### Profile

The profile extension introduces colors to bash and fetches the current git branch if possible.

### Git

Show a compact and colorful git log:

	gl

Show the complete git log:

	gll

### DevEnv

Creates the following directories:

```
~/Development/Projects
~/Development/Boxes
~/Development/Experiments
```
Quick cd to the projects directory:

	p
	
Quick cd to the projects boxes:

	b
	
Quick cd to the projects experiments:

	e		

### finder (macOS only)

The finder extension introduces the following aliases:

Open the current folder in Finder:  

	f

Cd to the current Finder folder:  
	
	cdf

Show system files:  
	
	files_unhide
	
Show system files:  
	
	files_hide
	
Move a directory or file to the trash:  
	
	trash /dir/another/dir