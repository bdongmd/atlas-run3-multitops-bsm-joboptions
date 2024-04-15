from argparse import ArgumentParser
from itertools import product
from condor_handler import CondorHandler
import os
import random


parser = ArgumentParser()
parser.add_argument("-d", "--dsids", nargs="+", type=int)

parser.add_argument(
    "--ecmEnergy",
    help="Center of mass energy(s) default: [13_600., 13_000.]",
    type=float,
    nargs="+",
    # default=[13_600., 13_000.],
    default=[13_600.],
)

parser.add_argument(
    "--seed",
    help="Random seed",
    type=int,
    nargs="+"
)

args = parser.parse_args()


batch_dir = os.path.join(os.getcwd(), "rivet_condor")
batch_path = os.path.join(batch_dir, "batch")
log_path = os.path.join(batch_dir, "batch_logs")
for item in [batch_path, log_path]:
    if not os.path.exists(item): os.makedirs(item)

handler = CondorHandler(batch_path, log_path)
handler['runtime'] = 259_199 # in seconds (7200 = 2h, 28_800 = 8h, 43_200 = 12h, 86_399 < 24h, 259_199 < 3d)
handler['memory'] = "8GB"
handler['cpu'] = 1
handler['project'] = "af-rivet-atlas"
## only for lxplus
handler['jobflavour'] = "workday"

for dsid, com in product(args.dsids, args.ecmEnergy):
    seed = args.seed
    tag = "rivet_{dsid}_{com}TeV_{seed}".format(dsid=dsid, com=int(com)*0.001, seed=seed)
    workdir = os.getcwd()

    command = "cd {0} && source {0}/setup.sh && bash {0}/run_rivet_batch.sh ".format(workdir)
    command += " {dsid} {com} {seed}".format(dsid=dsid, com=com, seed=seed)

    handler.send_job(command, tag)
