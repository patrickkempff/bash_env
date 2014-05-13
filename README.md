# Bash profile for Terminal

A .bash_profile for your convenience. This profile enables colors and introduces handy custom commands to your terminal.

## A quick primer on .bash_profile for mac users

There is a hidden file in your Mac’s user directory named .bash_profile. This file is loaded before Terminal loads your shell environment and contains all the startup configuration and preferences for your command line interface. Within it you can change your terminal promt, change the colors of text, add aliases to functions you use all the time, and so much more.


## Getting Started

To install, just paste this into the terminal:

	curl -3s https://raw.githubusercontent.com/patrickkempff/bash_profile/master/install.sh | bash

Once the profile has been installed, you can update it by typing the following command:

	bash_profile_update

## Usage examples

Only the primarily commands are listed below , so please consider [the profile itself](bash_profile) as required reading for optimal usage.

### General

Quick cd to the Development directory:  

	dev

Quick cd to the Vagrant boxes directory:  

	vgb

Remove all .DS_Store files (recursivly):  

	remove_ds

Open a file in Sublime Text:  

	slt file.ext

Create a new file and open it in Sublime Text:  

	sltn file.ext

Open the current folder in Finder:  

	f

Cd to the current Finder folder:  
	
	cdf

Create a new folder and cd inside:  
	
	mcd

Generate a random password salt with a given length or a default length of 32 if none is given: 

	salt
	salt 64
	salt 16

Generate a random password:

	password

### Git

Show a compact and colorful git log:

	gl

Show the complete git log:

	gll


Open the GitHub/Beanstalk web page of the current git repository:  
	
	repo
	github
	beanstalk


### Networking

View the response headers of a given url:  

	headers google.nl


View the public facing ip adress:  

	myip

List all active connections:  

	connections

Flush the DNS cache: 

	flush_dns

### Dummy files

You can use `make1mb`, `make5mb`, `make10mb`, `make100mb` and `make1gb` to generate a dummy file of the given size (all zeros).



## Special thanks:

Nathaniel Landau, http://natelandau.com/  
Alias, http://alias.sh/
Dion Snoeijen, http://www.diovisuals.com/

