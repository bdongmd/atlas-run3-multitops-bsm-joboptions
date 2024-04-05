#!/bin/bash

# enable model
export PYTHONPATH=$PWD/models:$PYTHONPATH

# set DSID
DSID=${1}
if [[ -z ${DSID} ]]; then
    echo "DSID not provided, using 100000 as default.";
    DSID=100000;
fi

# center of mass energy (in GeV)
COMENERGY=${2}
if [[ -z ${COMENERGY} ]]; then
    echo "center of mass energy not provided, using 13000. as default.";
    COMENERGY=13600.;
fi

# Input LHE file
INPUTGENFILE=${3}
if [[ -z ${INPUTGENFILE} ]]; then
    echo "input generator file not provided, using TXT.29916609._000001.tar.gz.1 as default.";
fi

# launch job
TAG=${DSID}_${COMENERGY/.*}GeV
RESULTDIR=$PWD/output/$TAG
TMPWORKDIR=/tmp/evtgen_$TAG


export RIVET_ANALYSIS_PATH=$RIVET_ANALYSIS_PATH:$PWD/rivet/

SUBMIT_TAG=${DSID}_${COMENERGY/.*}GeV_04042024
SUBMIT_GRID='pathena --trf "Gen_tf.py --maxEvents=100000 --ecmEnergy='$COMENERGY' --randomSeed=%RNDM:1000 --jobConfig='${DSID}' --outputEVNTFile %OUT.EVNT.root" --outDS user.rqian.ttZprime'$SUBMIT_TAG' --split 10 --excludeFile output --memory=4096'
echo $SUBMIT_GRID
$SUBMIT_GRID

ls
pwd
# rm -rf $TMPWORKDIR
cd -
