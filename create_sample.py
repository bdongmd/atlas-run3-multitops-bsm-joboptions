import os
from argparse import ArgumentParser
import random


parser = ArgumentParser()

parser.add_argument(
    "--DSID",
    help="DSID",
    default= 100836,
)

parser.add_argument(
    "--mass",
    help="Mass of the Zprime in GeV",
    type=float,
    default=3000.,
)

parser.add_argument(
    "--ct",
    help="Value for Parameter ct",
    type=str,
    default='1.0',
)

parser.add_argument(
    "--theta",
    help="Value for Parameter theta",
    type=float,
    default=0.79,
)

parser.add_argument(
    "--reweight",
    help="Whether do the ME reweighting",
    type=bool,
    nargs="+",
    default=False,
)

parser.add_argument(
    "--process",
    help="  'restt': 'resonant s-channel production of BSM resonance: tt + Zp, Zp > tt',\
            'resjt': 'resonant s-channel production of BSM resonance: tj + Zp, Zp > tt',\
            'reswt': 'resonant s-channel production of BSM resonance: tW + Zp, Zp > tt',\
            'tttt': 'BSM four top quark production with resonance, tt + tt considering both s- and t-channel processes',\
            'ttjt': 'BSM four top quark production with resonance, tj + tt',\
            'ttwt': 'BSM four top quark production with resonance, tw + tt',\
            'ttttsm': 'SM+BSM four top quark production with resonance, considering both s- and t-channel processes' ",
    type=str,
    default='',
)

args = parser.parse_args()

DSID = args.DSID
signal = "ttZp"
process_id = args.process
mass = int(args.mass)
ct = str(str(args.ct).replace('.', 'p'))
theta = str(str(args.theta).replace('.', 'p'))
reweight = args.reweight

JO_name = "mc.MGPy8EG_ttZp_{0}_m{1}_ct{2}_th{3}.py".format(process_id,mass,ct,theta)

print("JO to create:" + JO_name)
# print summary of options
print("Job option parameters:")
print("- process ID {p}".format(p=DSID))
print("- resonance mass {p}".format(p=mass))
print("- resonance coupling to top quarks {p}".format(p=ct))
print("- chirality parameter {p}".format(p=theta))
print("- ME reweighting enabled {p}".format(p=reweight))

DSID_path = "100xxx/"+str(DSID)
if os.path.exists(DSID_path):
    print("DSID "+str(DSID)+"exist! Please double check!")
else:
    os.mkdir(DSID_path)
    with open(os.path.join(DSID_path, JO_name), 'w') as JOfile:
        if reweight == 0 or process_id == "ttttsm":
            JOfile.write("reweight = False\n")
        JOfile.write('include("../100800/MadGraphControl_TopPhilicG_4t_v2.py")')

print("JO for DSID "+str(DSID)+" created!")
