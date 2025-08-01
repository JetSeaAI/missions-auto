#!/bin/bash 
#------------------------------------------------------------
#   Script: init_field.sh
#   Author: M.Benjamin
#   LastEd: Apr 11th 2025
#------------------------------------------------------------
#  Part 1: A convenience function for producing terminal
#          debugging/status output depending on verbosity.
#------------------------------------------------------------
vecho() { if [ "$VERBOSE" != "" ]; then echo "$ME: $1"; fi }

#------------------------------------------------------------
#  Part 2: Set global variable default values
#------------------------------------------------------------
ME=`basename "$0"`
VEHICLE_AMT="5"
VERBOSE=""
RAND_VPOS="no"

# custom

#------------------------------------------------------------
#  Part 3: Check for and handle command-line arguments
#------------------------------------------------------------
for ARGI; do
    CMD_ARGS+=" ${ARGI}"
    if [ "${ARGI}" = "--help" -o "${ARGI}" = "-h" ]; then
	echo "$ME [OPTIONS] [time_warp]                      "
	echo "                                               "
	echo "Options:                                       "
#	echo "  --amt=N            Num vehicles to launch    "
	echo "  --verbose, -v      Verbose, confirm values   "
	echo "                                               "
	echo "Options (custom):                              "
       exit 0;
#    elif [ "${ARGI:0:6}" = "--amt=" ]; then
#        VEHICLE_AMT="${ARGI#--amt=*}"
    elif [ "${ARGI}" = "--verbose" -o "${ARGI}" = "-v" ]; then
	VERBOSE=$ARGI
    elif [ "${ARGI}" = "--rand" -o "${ARGI}" = "-r" ]; then
        RAND_VPOS="yes"
    else 
	echo "$ME: Bad Arg: $ARGI. Exit Code 1."
	exit 1
    fi
done

#------------------------------------------------------------
#  Part 4: Source local coordinate grid if it exits
#------------------------------------------------------------

#------------------------------------------------------------
#  Part 5: Set starting positions, speeds, vnames, colors
#------------------------------------------------------------
vecho "Setting starting position, speeds, vnames, colors"

echo "x=70,y=-90,heading=0" > vpositions.txt
echo "x=40,y=-40,heading=180"  >> vpositions.txt
echo "x=60,y=-40,heading=180"  >> vpositions.txt
echo "x=80,y=-40,heading=180"  >> vpositions.txt
echo "x=100,y=-40,heading=180" >> vpositions.txt

echo 0 >  vspeeds.txt
echo 0 >> vspeeds.txt
echo 0 >> vspeeds.txt
echo 0 >> vspeeds.txt
echo 0 >> vspeeds.txt

echo "x=70,y=-10" >  vdestpos.txt
echo "x=40,y=-120"  >> vdestpos.txt
echo "x=60,y=-120"  >> vdestpos.txt
echo "x=80,y=-120"  >> vdestpos.txt
echo "x=100,y=-120" >> vdestpos.txt

echo "ownship" > vsource.txt
echo "radar"   >> vsource.txt
echo "arpa"  >> vsource.txt
echo "radar" >> vsource.txt
echo "ais" >> vsource.txt

pickpos --amt=$VEHICLE_AMT --vnames  > vnames.txt
pickpos --amt=$VEHICLE_AMT --colors  > vcolors.txt

#------------------------------------------------------------
#  Part 6: Set other aspects of the field, e.g., obstacles
#------------------------------------------------------------

#------------------------------------------------------------
#  Part 7: If verbose, show file contents
#------------------------------------------------------------
if [ "${VERBOSE}" != "" ]; then
    echo "--------------------------------------"
    echo "VEHICLE_AMT = $VEHICLE_AMT"
    echo "RAND_VPOS   = $RAND_VPOS"
    echo "--------------------------------------(pos/spd)"
    echo "vpositions.txt:"; cat  vpositions.txt
    echo "vspeeds.txt:";    cat  vspeeds.txt
    echo "--------------------------------------(vprops)"
    echo "vnames.txt:";     cat  vnames.txt
    echo "vcolors.txt:";    cat  vcolors.txt
    echo -n "Hit any key to continue"
    read ANSWER
fi

exit 0
