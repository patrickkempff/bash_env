#!/bin/bash
 
# Figure out what the run path of the current script is.
pushd . > /dev/null
BASH_ENV_RUN_DIR="${BASH_SOURCE[0]}";
if ([ -h "${BASH_ENV_RUN_DIR}" ]) then
while([ -h "${BASH_ENV_RUN_DIR}" ]) do cd `dirname "$BASH_ENV_RUN_DIR"`; BASH_ENV_RUN_DIR=`readlink "${BASH_ENV_RUN_DIR}"`; done
fi
cd `dirname ${BASH_ENV_RUN_DIR}` > /dev/null
cd ..

export BASH_ENV_RUN_DIR=`pwd`;
export BASH_ENV_RUN_PATH=$BASH_ENV_RUN_DIR/bash_env
export BASH_ENV_EXTENSION_PATH="${BASH_ENV_RUN_DIR}/extensions";
export BASH_ENV_INSTALL_DIR="${HOME}/.bash_env"

if [ -z ${BASH_ENV_EXTENSIONS_LOADED+x} ]; then
  export BASH_ENV_EXTENSIONS_LOADED=()
fi

# Bash color helpers
benv_bold=$(tput bold)
benv_normal=$(tput sgr0)
benv_green=$(tput setaf 2)
benv_red=$(tput setaf 1)
benv_yellow=$(tput setaf 3)
benv_dim=$(tput dim)

popd  > /dev/null