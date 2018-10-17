#!/bin/bash

# see the following for further information
# https://www.pci.uni-heidelberg.de/cms/mctdh.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc/index.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc.85/mctdh/gen.html
# https://www.pci.uni-heidelberg.de/tc/usr/mctdh/doc/mctdh/svn.pdf


# ------------------------------------------------------------------------------------------------------------
# path & file name variables - change these two as needed
# ------------------------------------------------------------------------------------------------------------
SRC_FILE="./mctdh85.9.tgz"
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
echo "Finished unzipping tar"
# ------------------------------------------------------------------------------------------------------------
# Step 0 (run check_system)
# ------------------------------------------------------------------------------------------------------------
${MCTDH_DIR}install/check_system
echo "Finished Step 0 - checking the system"
# ------------------------------------------------------------------------------------------------------------
# Step 1 (run the config script - which runs the install script)
# ------------------------------------------------------------------------------------------------------------
export PAGER=cat
# first arg is the directory which expect will cd to and execute the install.sh script whithin
./expect_config_script.sh $MCTDH_DIR
echo "Finished Step 1 - running the config script"
# ------------------------------------------------------------------------------------------------------------
# Step 2 (add environment variablaes to .bash)
# ------------------------------------------------------------------------------------------------------------
# The script $MCTDH_DIR/install/mctdh.profile includes the paths for the script files and executables into your $PATH environment variable.
# It also sets the environment variable $MCTDH_VERSION with the version number of the package.
# This is required by various scripts used to run the programs.
#
# you can add these following lines to your preference of .bash_profile/.bashrc/.profile/.bash_include etc.
# ------------------------------------------------------------------------------------------------------------
# export MCTDH_DIR=$MCTDH_DIR
# source $MCTDH_DIR/install/mctdh.profile
# ------------------------------------------------------------------------------------------------------------
# or you can source the following file
# $MCTDH_DIR/install/MCTDH_client
# (although this creates a soft link in your user directory which might be undesirable)
# ------------------------------------------------------------------------------------------------------------
# Step 3 (manually configuring afterwards)
# ------------------------------------------------------------------------------------------------------------
# you may want to copy /$MCTDH_DIR/install/mctdhrc to /home/$USER/.mctdhrc
# and change your .bashrc to source it
#
# you may need to add the following to your path
# $MCTDH_DIR/bin/binary/x84_64
# $MCTDH_DIR/bin
#

# had to modify
# source/include/paths.inc after sourcing ~/.mctdhrc

echo "Finished with everything"

# A module file for the server should contain
# ------------------------------------------------------------------------------------------------------------
# export MCTDH_DIR=$MCTDH_DIR
# source $MCTDH_DIR/install/mctdh.profile
# export PATH=$PATH:$MCTDH_DIR/bin/binary/x84_64
# export PATH=$PATH:$MCTDH_DIR/bin
# ------------------------------------------------------------------------------------------------------------


