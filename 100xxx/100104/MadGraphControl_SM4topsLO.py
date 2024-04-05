from MadGraphControl.MadGraphUtils import *
import fileinput

# General settings

# Number of events
minevents = int(runArgs.maxEvents)
nevents = minevents*1.1
nevents = int(nevents)

# PDF
pdflabel = 'lhapdf'
lhaid = 315000 # NNPDF31_lo_as_0118

# MadSpin
bwcut = 15

# Systematics
syst = "T"


#---------------------------------------------------------------------------
# MG5 Proc card
#---------------------------------------------------------------------------

mgproc = """generate p p > t t~ t t~"""
name = "SM4topsLO"
process = "pp>tt~tt~"
keyword = ['SM','top','4top','LO']
topdecay = "decay t > w+ b, w+ > all all \ndecay t~ > w- b~, w- > all all \n"


process_string = """
import model sm
define p = g u c d s u~ c~ d~ s~
define j = g u c d s u~ c~ d~ s~
"""+mgproc+"""
output -f
"""


#---------------------------------------------------------------------------
# MG5 Run Card
#---------------------------------------------------------------------------

#Fetch default LO run_card.dat and set parameters
extras = {
    'dynamical_scale_choice':3,
    'lhe_version'  : '3.0',
    'pdlabel'      : pdflabel,
    'lhaid'        : lhaid,
    'use_syst'     : syst,
    'sys_scalefact': '1 0.5 2',
    'sys_pdf'      : "NNPDF31_lo_as_0118",
    'event_norm'   : "sum",
    'nevents'        : nevents,
    }

process_dir = new_process(process=process_string)
modify_run_card(process_dir=process_dir, runArgs=runArgs, settings=extras)
print_cards()

#---------------------------------------------------------------------------
# MadSpin Card
#---------------------------------------------------------------------------

madspin_card_loc=process_dir+'/Cards/madspin_card.dat'
mscard = open(madspin_card_loc,'w')
mscard.write("""#************************************************************
#*                        MadSpin                           *
#*                                                          *
#*    P. Artoisenet, R. Frederix, R. Rietkerk, O. Mattelaer *
#*                                                          *
#*    Part of the MadGraph5_aMC@NLO Framework:              *
#*    The MadGraph5_aMC@NLO Development Team - Find us at   *
#*    https://server06.fynu.ucl.ac.be/projects/madgraph     *
#*                                                          *
#************************************************************
set BW_cut %i
set seed %i
%s
launch
"""%(bwcut, runArgs.randomSeed, topdecay))
mscard.close()


#---------------------------------------------------------------------------
# MG5 Generation
#---------------------------------------------------------------------------

generate(process_dir=process_dir, runArgs=runArgs)
arrange_output(process_dir=process_dir, runArgs=runArgs, lhe_version=3, saveProcDir=True)



#---------------------------------------------------------------------------
# Parton Showering Generation
#---------------------------------------------------------------------------

check_reset_proc_number(opts)

evgenConfig.generators += ["MadGraph"]
evgenConfig.keywords += keyword
evgenConfig.contact = ['S. Berlendis <simon.berlendis@cern.ch>',
                       'NA. Nedaa-Alexandra <nedaa.asbah@cern.ch>',
                       'P. Sabatini <paolo.sabatini@cern.ch>',
                       'L. Serkin <Leonid.Serkin@cern.ch>']

evgenConfig.generators += ["Pythia8"]
evgenConfig.description = 'Standard-Model 4tops production at LO with MadGraph5 and Pythia8'
include("Pythia8_i/Pythia8_A14_NNPDF23LO_EvtGen_Common.py")
include("Pythia8_i/Pythia8_MadGraph.py")
