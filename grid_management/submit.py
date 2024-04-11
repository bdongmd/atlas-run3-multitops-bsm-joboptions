from argparse import ArgumentParser
from itertools import product
from grid_handler import GridHandler
import os
import random


parser = ArgumentParser()
parser.add_argument("-d", "--dsids", nargs="+", default=[], type=int)
parser.add_argument(
    "--eventsPerJob",
    help="Events generated per job, default: 10000",
    type=int,
    default=10000,
)
parser.add_argument(
    "--ecmEnergy",
    help="Center of mass energy(s) default: 13600",
    type=float,
    default=13600,
)

parser.add_argument(
    "--split",
    help="Number of splits for grid job",
    type=int,
    default=10,
)

parser.add_argument(
    "--njobs",
    help="Number of grid jobs. ",
    type=int,
    default=10,
)

parser.add_argument(
    "--post",
    help="postfix of the grid",
    type=str,
    default="",
)

parser.add_argument(
    "--user",
    help="grid user name",
    type=str,
    default="rqian",
)

args = parser.parse_args()

seed_list = []

for n in range(args.njobs):
    for dsid in (args.dsids):
        seed = int(random.uniform(100000, 500000))
        while seed in seed_list:
            seed = int(random.uniform(100000, 500000))
        handler = GridHandler()
        handler.send_job(dsid, args.ecmEnergy,args.eventsPerJob,args.njobs, args.split, seed, args.user, args.post)
