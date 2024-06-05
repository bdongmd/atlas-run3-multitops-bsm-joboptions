#!/bin/bash

EVENTS=100000             # Events per job
GRIDPACK=1                # Control of gridpack mode (see README for more information)

#######################################################
# Use this block if generating events from gridpack
# The DSID and SEED should corresponding to each other
# ecmEnergy can be only 13000 or 13600
#######################################################
#DSIDS="100802"
#SEED="230129"

#COMMAND="python batch_management/submit.py --eventsPerJob ${EVENTS} -d ${DSIDS} --gridpack ${GRIDPACK} --ecmEnergy 13000 --seed ${SEED}"

#######################################################
# Use this block in other case
#######################################################

DSIDS="100812 100813 100814 100815 100816 100817 100818 100819 100820 100821 100822 100823"
COMMAND="python batch_management/submit.py --eventsPerJob ${EVENTS} -d ${DSIDS} --gridpack ${GRIDPACK} --ecmEnergy 13000. 13600."


#######################################################

echo $COMMAND
$COMMAND
