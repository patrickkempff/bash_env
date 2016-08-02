#!/bin/bash

# Because bash does not support native classes, we define 
# the needed functions in this file. 
 
function bash_env_install()
{
    # Check if the force argument has been given.
    local force_install=false
    if [ "$2" = "--force" ] || [ "$2" = "-f" ]; then
        force_install=true
    fi

    # Check if a file exists, if so this is something unexpected because 
    # bash_env will install as a directory.
    if [ -f $BASH_ENV_INSTALL_DIR ]; then 
        echo "[${benv_red}ERROR${benv_normal}] Could not install, there is already a file named ~/.bash_env."
        exit 1;
    fi

    # Check if bash_env already is installed.
    if [ -d $BASH_ENV_INSTALL_DIR ] && [ -n "$(ls -A $BASH_ENV_INSTALL_DIR)" ]; then
        if [ "$force_install" = false ]; then
            # Notify the user that bash_env is already installed.
            echo "[${benv_red}ERROR${benv_normal}] Already installed, use the flag ${benv_bold}--force${benv_normal} to override the installation."
            exit 1;        
        else
            # bash_env is already installed but the user has given the -force flag.
            # this means the old installation will be removed before the installation itself.
            echo "[${benv_yellow}INFO${benv_normal}] Installation of bash_env detected in $BASH_ENV_INSTALL_DIR"
            # Wait for a half second.
            sleep 0.5;
            
            echo "[${benv_yellow}INFO${benv_normal}] Removing older installation of bash_env..."

            # Remove the previous installation of bash_env.
            rm -rf $BASH_ENV_INSTALL_DIR

            # Wait for 1 second.
            sleep 1;        
        fi
    fi

    # If the force flag is not given, ask the user if he/she wants to 
    # install bash profile.
    if [ "$force_install" = false ]; then
        read -p "Do you want to run the install bash_env in ${bold}${BASH_ENV_INSTALL_DIR}${normal}? (Y/n) " -n 1 -r
        echo    # (optional) move to a new line

        # The user has replied something else then 'y', abort the installation.
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "[${benv_yellow}INFO${benv_normal}] Installation aborted."
            exit 1;
        fi
    fi

    # Let the user know that we are installing bash_env, also tell them where
    # bash_env is going to be installed.
    echo "[${benv_yellow}INFO${benv_normal}] Installing bash_env in $BASH_ENV_INSTALL_DIR... please wait..."
    # Wait for 2 seconds.
    sleep 2; 

    # Install bash_env into the given installation dir 
    # by default  this is $HOME/.bash_env/*.

    # First copy the contents of RUN_DIR into the installation dir.
    cp -R $BASH_ENV_RUN_DIR $BASH_ENV_INSTALL_DIR 
    
    # Make sure the bash_env script can be executed.
    chmod a+x "$BASH_ENV_INSTALL_DIR/bash_env"

    # Figure out which profile can be used to include a reference to 
    # bash_env script.
    if [[ ! -s "$HOME/.bash_profile" && -s "$HOME/.profile" ]] ; then
        profile_file="$HOME/.profile"
    else
        profile_file="$HOME/.bash_profile"
    fi  

    # Make sure bash_env is only included once by checking if bash_env
    # is already included in the profile file.
    if ! grep -q "source ${BASH_ENV_INSTALL_DIR}/bash_env" "${profile_file}" ; then
        # Let the user know we are going to include bash_env.
        echo "Loading ${BASH_ENV_INSTALL_DIR} into ${profile_file}"

        # Include bash_env into the profile file.
        echo "source ${BASH_ENV_INSTALL_DIR}/bash_env" >> "${profile_file}"
    fi

    # Let the user know the installation is completed and 
    # the terminal needs to be restarted.
    echo -e "[${benv_green}SUCCESS${benv_normal}] bash_env installed, please ${benv_bold}restart${benv_normal} the terminal now!"

}

# Initialize bash_env, load the enabled extensions
# according to enabled.conf
function bash_env_initialize()
{
    # Create an empty enabled.conf if it 
    # does not exist. 
    if [ ! -f "${BASH_ENV_RUN_DIR}/enabled.conf" ]; then
        touch "${BASH_ENV_RUN_DIR}/enabled.conf"
    fi

    # Load the enabled.conf
    source "${BASH_ENV_RUN_DIR}/enabled.conf"
}

# Load the given extension into memory.
#
# @param  string     Name of the function.
# @return bool       true when the function exists.
function bash_env_extension_load()
{
    local save=false
    local "${@}"
    local extension=$1
    local path="$BASH_ENV_EXTENSION_PATH/$1"
    # Check if module exists.
    if [ -f $path ];
    then
        source $path; 
        local load="_load";
        local req="_requirements";
        
        # validate extension
        if bash_env_function_exists $extension$req && bash_env_function_exists $extension$load
        then
            # check if the requirements are met.
            if $extension$req
            then
                # Enable extension if needed
                if $save 
                then
                    bash_env_extension_enable $extension;
                fi  
                
                # Load the extension
                $extension$load;     
                
                BASH_ENV_EXTENSIONS_LOADED=("${BASH_ENV_EXTENSIONS_LOADED[@]}" $extension);            
            fi
        else 
            echo "Not a valid module." 
        fi
        
    else
        echo "File $path does not exist."
    fi
}

# Check if the given function exists.
#
# @param  string     Name of the function.
# @return bool       true when the function exists.
function bash_env_function_exists() 
{
    declare -f -F $1 > /dev/null
    return $?
}

