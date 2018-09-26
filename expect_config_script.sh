#!/usr/bin/expect
# ------------------------------------------------------------------------------------------------------------
# get the input - and set constants
set MCTDH_DIR [lindex $argv 0];
# set intel_mkl_path [lindex $argv 1];
# set build_dir $src_dir;
# set gamess_version "R2";
# set gfortran_version "7.3";
# ------------------------------------------------------------------------------------------------------------
# go to the install directory
cd $MCTDH_DIR;
# set timeout to 10 seconds
set timeout 10;
# set the output to 'debug' mode so that we can see what the expect script see's
# this can be quite messy as the output from the program and expect can clobber each other
# exp_internal 1

# another way to control output
log_user 0
# log_user 1

send_user "Starting script\n";
# start the config script that we will interact with
spawn "./install/install_mctdh";
# ------------------------------------------------------------------------------------------------------------
expect "*(b|c|k|p|y|n) ?*" { # I suggest the user manually adds these commands to their preferred file
	# Choose: b) write the commands to my ~/.bashrc file (for bash users).
	# Or    : c) rather write them to my ~/.cshrc file (for csh and tcsh users).
	# Or    : k) rather write them to my ~/.kshrc file (kcsh users).
	# Or    : p) please, rather write them to my ~/.profile file.
	#           (alternative for ksh and bash users (not recommended)).
	# Or    : y) yes, write the commands to my ~/.bashrc file.  (same as b)).
	# Or    : n) no, do not touch my configuration files.
    send "n\r";
}
expect "*Shall I copy mctdhrc to \$HOME/.mctdhrc (y/n) ?*" {
	#  The file mctdhrc may be copied to $HOME/.mctdhrc.
	#  The .bashrc will then source .mctdhrc.
	#  Doing so, the bash-functions cdm and minstall will be available
	#  and a link $HOME/mctdh -> $MCTDH_DIR will be installed.
    send "y\r";
}
expect "*(y|n|le|be|lenp|benp) ?*" {
# "y" or "le" if you want the LITTLE ENDIANS format and parallelization.
#  "n" or "be" if you want the BIG ENDIANS format and parallelization.
#  "lenp" if you want the LITTLE ENDIANS format without parallelization.
#  "benp" if you want the BIG ENDIANS format without parallelization.
    send "y\r";
}
expect "*Would you like to compile the Latex documentation now ?*" {
	# Some of the documentation is stored as Latex files. These need
	# to be compiled before they can be read.
	# Would you like to compile the Latex documentation now ?
    send "y\r";
}
expect "*Would you like to compile the programs now ?*" {
	# Some of the documentation is stored as Latex files. These need
	# to be compiled before they can be read.
	# Would you like to compile the Latex documentation now ?
    send "y\r";
}
# ------------------------------------------------------------------------------------------------------------

interact