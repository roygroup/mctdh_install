#!/bin/bash

# see the following for further information
# https://www.pci.uni-heidelberg.de/cms/mctdh.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc/index.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc.85/mctdh/gen.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc/mctdh/svn.pdf


# ------------------------------------------------------------------------------------------------------------
# path & file name variables - change these two as needed
# ------------------------------------------------------------------------------------------------------------
SRC_FILE="./mctdh84.16.tgz"
VERSION_NUM=${SRC_FILE#"./mctdh"} # remove the prefix
VERSION_NUM=${VERSION_NUM%".tgz"} # remove the suffix
MCTDH_DIR=/home/ngraymon/.dev/ubuntu_18.04/mctdh/mctdh$VERSION_NUM/
# echo $VERSION_NUM
echo "Attempting to install version $VERSION_NUM of MCTDH"
# ------------------------------------------------------------------------------------------------------------
if [ ! -f $SRC_FILE ]; then
    echo "src file $SRC_FILE could not be found";
    exit 0;
fi
mkdir -p $MCTDH_DIR
# ------------------------------------------------------------------------------------------------------------
# Step -1 (unzip to target directory)
# ------------------------------------------------------------------------------------------------------------
# --skip-old-files speeds up the script if it needs to be re-run - assuming the files do not need to overwritten
tar xzf $SRC_FILE -C $MCTDH_DIR --strip-components=1 --skip-old-files
# ------------------------------------------------------------------------------------------------------------
# Step 0 (run check_system)
# ------------------------------------------------------------------------------------------------------------
${MCTDH_DIR}install/check_system
# ------------------------------------------------------------------------------------------------------------
# Step 1 (add environment variablaes to .bash)
# ------------------------------------------------------------------------------------------------------------
# The script $MCTDH_DIR/install/mctdh.profile includes the paths for the script files and executables into your $PATH environment variable.
# It also sets the environment variable $MCTDH_VERSION with the version number of the package.
# This is required by various scripts used to run the programs.

# add these following lines to your preference of .bash_profile/.bashrc/.profile/.bash_include etc.
# ------------------------------------------------------------------------------------------------------------
# export MCTDH_DIR=$MCTDH_DIR
# source $MCTDH_DIR/install/mctdh.profile
# ------------------------------------------------------------------------------------------------------------
# Step 2 (run the config script)
# ------------------------------------------------------------------------------------------------------------
export PAGER=cat
# first arg is the directory which expect will cd to and execute the install.sh script whithin
./expect_config_script.sh $MCTDH_DIR
echo "Finished Step 4 - running the config script"
# ------------------------------------------------------------------------------------------------------------

# had to modify
# source/include/paths.inc after sourcing ~/.mctdhrc
