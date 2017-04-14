# Bash Environment / Bash Profile

bash_env is a modulair approach of hanling config, aliases and scripts in bash. It enables colors and introduces handy custom commands to your terminal.

## Gettings started

Start by cloning the repo:

	git clone https://github.com/patrickkempff/bash_env.git && cd bash_env

and install bash_env by typing the following command:

	./bash_env install

## Extensions

By default bash_env ships with the following extensions:

- [extensions/profile](#profile)
- [extensions/filesystem](#filesystem)
- [extensions/networking](#networking)
- [extensions/devenv](#devenv)
- [extensions/finder](#finder-macos-only) (macOS only)
- [extensions/git](#git)
- [extensions/makefile](#makefile)
- [extensions/npm](#npm)

To enable/disable certain extensions take a look at the [enabled.conf](enabled.conf) file.

### Profile

The profile extension introduces colors to bash and fetches the current git branch if possible.

### Filesystem

Recursively list the directory contents:

	lr

Remove all .DS_Store files in the current directory and its parents:

	remove_ds

Go to the parent directory:

	..

Go to the parent of the parent directory:

	...
	
### Networking

View the response headers of a given url:  

	headers google.nl


View the public facing ip adress:  

	myip

List all active connections:  

	connections


### Git

Show a compact and colorful git log:

	gl

Show the complete git log:

	gll

### DevEnv

Creates the following directories for your dev environment:

```
~/Development/Projects
~/Development/Boxes
~/Development/Experiments
```
Quick cd to the projects directory (~/Development/Projects):

	p
	
Quick cd to the boxes directory  (~/Development/Boxes):

	b
	
Quick cd to the experiments directory  (~/Development/Experiments):

	e	

Quick cd to the notes directory  (~/Development/Notes):

	n		

### Finder (macos only)

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
	
### Makefile

You can use `make1mb`, `make5mb`, `make10mb`, `make100mb`, `make1gb`, `make10gb` and `make100gb` to generate a dummy file of the given size (all zeros).

### npm

One nice npm feature is that you can install packages with executables locally. 
When executables are installed via npm packages, npm links to them:

* In local installs, they are linked to from a node_modules/.bin/ directory.
* In global installs, they are linked to from a global bin/ directory (e.g. /usr/local/bin).

When working with multiple project which have their own local node dependencies (like webpack, gulp etc.), it is a best practice to only install the package locally instead of globally (to prevent version conflicts). 

One thing to keep in mind is that if you want to run the local webpack binary (from node_modules/.bin) you have 2 options;

1. add an npm script 
2. prepend the node_modules/.bin folder to the command you want to execute.

Sometimes it is not feasable to add an sepperate npm script for each node_module binary and that is where npm-do comes into play.
To execute the binary located at node_modules/.bin/webpack, just run
	
	npm-do webpack -p --colors
	
