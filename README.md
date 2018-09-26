# Multi Configuration Time Dependent Hartree (MCTDH) install script
This is a self contained bash script that attempts to automate the process of installing the MCTDH package on the roygroup cluster.

To install
----------
Change the path to the source file for MCTDH ( on line 13 )
```
SRC_FILE="./mctdh84.16.tgz"
```
and the mctdh directory ( on line 16 )
```
MCTDH_DIR=/home/ngraymon/.dev/ubuntu_18.04/mctdh/mctdh$VERSION_NUM/
```
then run the script:
```
./mctdh_install.sh
```

You will then need to add the following to whichever flavour of .bashrc/.bash_profile/.profile/.bash_include you prefer
```
export MCTDH_DIR=$MCTDH_DIR
source $MCTDH_DIR/install/mctdh.profile
```

The expect_config_script handles the configuration of gamess
