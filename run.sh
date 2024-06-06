#!/bin/bash

# sh run.sh 100920

# global settings
RUNRIVET=1 # set to 0 if you do not wish the run rivet right after evgen.
MAKERIVETPLOTS=0 # set to 1 if you wish to produce the rivet plots and html files (must have RUNRIVET=1), otherwise set to 0
RIVETTITLE="tt+X plots" # if using MAKERIVETPLOTS

# enable model
export PYTHONPATH=$PWD/models:$PYTHONPATH

# set DSID
DSID=${1}
if [[ -z ${DSID} ]]; then
    echo "DSID not provided, using 100000 as default.";
    DSID=100000;
fi

# number of events
NEVENTS=${2}
if [[ -z ${NEVENTS} ]]; then
    echo "number of events not provided, using 1 as default.";
    NEVENTS=1;
fi

# center of mass energy (in GeV)
COMENERGY=${3}
if [[ -z ${COMENERGY} ]]; then
    echo "center of mass energy not provided, using 13000. as default.";
    COMENERGY=13000.;
fi

# random number generator seed
SEED=${4}
if [[ -z ${SEED} ]]; then
    echo "random seed not provided, using 1234 as default.";
    SEED=1234;
fi

# turn on gridpack mode
GRIDPACK=${5}
if [[ -z ${SEED} ]]; then
    echo "gridpack mode is set to default off";
    GRIDPACK=0;
fi

# Input LHE file
INPUTGENFILE=${6}
if [[ -z ${INPUTGENFILE} ]]; then
    echo "input generator file not provided, running without it.";
fi

# launch job
if [[ $GRIDPACK -eq 0 ]]; then
TAG=${DSID}_${COMENERGY/.*}GeV_${SEED}_MCJO
fi
if [[ $GRIDPACK -eq 1 || $GRIDPACK -eq 2 ]]; then
TAG=${DSID}_${COMENERGY/.*}GeV_${SEED}_gridpack_MCJO
fi

# TMPWORKDIR should be this if not testing
TMPWORKDIR=/tmp/evtgen_$TAG

#tier3
RESULTDIR=/msu/data/t3work9/rongqian/atlascodingtutorial/atlas-run3-multitops-bsm-joboptions/output/$TAG
TMPWORKDIR=/msu/data/t3work9/rongqian/atlascodingtutorial/atlas-run3-multitops-bsm-joboptions/work_MCJO/evtgen_$TAG

# lxplus
#RESULTDIR=/eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/$TAG
#TMPWORKDIR=/eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output_work/$TAG

export RIVET_ANALYSIS_PATH=$RIVET_ANALYSIS_PATH:$PWD/rivet/

if [[ $GRIDPACK -ne 2 ]];then
mkdir -p $RESULTDIR
#comment this line if testing
rm -rf $TMPWORKDIR && mkdir -p $TMPWORKDIR
fi 

JOBFOLDER=${DSID:0:3}xxx
if [[ $GRIDPACK -ne 0 ]];then
JOBFOLDER=${DSID:0:3}xxx_gridpack
fi

cp -r --dereference $JOBFOLDER/$DSID $TMPWORKDIR


# if DSID is not 100800, copy the 100xxx/100800 folder as well
if [[ $DSID -ne 100800 && $DSID -gt 100799 && $DSID -lt 100900 ]]; then
    cp -r --dereference $JOBFOLDER/100800 $TMPWORKDIR/
fi
if [[ $DSID -ne 100910 && $DSID -gt 100899 && $DSID -lt 101000 ]]; then
    cp -r --dereference $JOBFOLDER/100910 $TMPWORKDIR/
fi
if [[ $DSID -ne 102010 && $DSID -gt 102000 && $DSID -lt 103000 ]]; then
    cp -r --dereference $JOBFOLDER/102010 $TMPWORKDIR/
fi

cp -r --dereference mcjoboptions/$JOBFOLDER/$DSID $TMPWORKDIR/ 
cp rivet/rivet.py $TMPWORKDIR
if [[ -f "${INPUTGENFILE}" ]]; then
  cp -r --dereference ${INPUTGENFILE} $TMPWORKDIR/
fi
cd $TMPWORKDIR

# Run event generation

if [[ $GRIDPACK -eq 0 ]];then
COMMAND="Gen_tf.py --firstEvent=1 --maxEvents=$NEVENTS --ecmEnergy=$COMENERGY --randomSeed=$SEED \
  --jobConfig=${DSID} --outputEVNTFile=test_DSID_${DSID}.EVNT.root"
if [[ -f "${INPUTGENFILE}" ]]; then
   COMMAND+=" --inputGeneratorFile=${INPUTGENFILE}"
fi
fi

if [[ $GRIDPACK -eq 1 ]];then
COMMAND="Gen_tf.py --firstEvent=1 --maxEvents=-1 --ecmEnergy=$COMENERGY --randomSeed=$SEED \
  --jobConfig=${DSID} --outputEVNTFile=test_gridpack_DSID_${DSID}.EVNT.root --outputFileValidation=False"
RUNRIVET=0
fi

if [[ $GRIDPACK -eq 2 ]];then
cd $TMPWORKDIR
ls $INPUTGENFILE
COMMAND="Gen_tf.py --firstEvent=1 --maxEvents=$NEVENTS --ecmEnergy=$COMENERGY --randomSeed=$SEED \
  --jobConfig=${DSID} --outputEVNTFile=test_DSID_${DSID}.EVNT.root"
if [[ -f "${INPUTGENFILE}" ]]; then
COMMAND+=" --inputGeneratorFile=${INPUTGENFILE}"
else
   cp $RESULTDIR/mc*tar.gz .
   MCfile=$(ls mc*tar.gz)
   COMMAND+=" --inputGeneratorFile=${MCfile}"
fi
fi

echo $COMMAND
$COMMAND

# Run rivet
if [[ $RUNRIVET -eq 1 ]]; then
    rm PoolFileCatalog.xml
    athena rivet.py --filesInput test_DSID_${DSID}.EVNT.root
    cp Rivet.yoda.gz $RESULTDIR/
fi 

# Diagnostics
ls
pwd

# copy results over
cp $TMPWORKDIR/test_DSID_${DSID}.EVNT.root $RESULTDIR/
cp $TMPWORKDIR/Rivet.yoda $RESULTDIR/
cat log.generate
cp $TMPWORKDIR/log.generate $RESULTDIR/log.generate_${GRIDPACK}
cp $TMPWORKDIR/mc*tar.gz $RESULTDIR/

#find $TMPWORKDIR/PROC_*/SubProcesses -type f -name "*.jpg" -exec cp --parents {} $RESULTDIR/ \;

# uncomment next line if testing
rm -rf $TMPWORKDIR
cd -

# Generate the rivet plots
if [[ $MAKERIVETPLOTS -eq 1 ]]; then
    cd $RESULTDIR
    rivet-mkhtml --errs --no-weights -o rivet_plots Rivet.yoda.gz:Title=$RIVETTITLE
    cd -
fi