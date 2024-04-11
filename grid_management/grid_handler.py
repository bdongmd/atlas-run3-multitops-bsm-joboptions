import os
import logging
import subprocess
logging.basicConfig(level=logging.INFO)


class GridHandler(object) :
  """
    A class to submit batch jobs to a GridCondor scheduler.

    ...

    Methods
    -------
    activate_testmode():
        Activate test mode, allowing for checks of config files in dry runs, no jobs submitted
    deactivate_testmode():
        Dctivate test mode, enable submitting jobs
    send_job(self,dsid,nevents,njobs, split, seed, user, prod_tag):
        Submit grid jobs with given args

  """
  def __init__(self):


    # internal options
    self._test_mode = False


  def __setitem__(self, key, value):
    self._condor_options[key] = value


  def __getitem__(self, key):
    return self._condor_options[key]


  def activate_testmode(self):
    logging.debug("Activated test mode: not submitting any jobs.")
    self._test_mode = True


  def deactivate_testmode(self):
    logging.debug("Deactivated test mode: submitting jobs.")
    self._test_mode = False

  def os_run(self,command):
    """
    wapper of os.system, if in test mode only print the command, else run
    """
    if self._test_mode == True:
      print(command)
    else:
      os.system(command)


  def send_job(self,dsid,ecmEnergy,nevents,njobs, split, seed, user, prod_tag):
    dsid = str(dsid)
    date='20240411'
    prod_tag = prod_tag + dsid + "_" + str(seed)
    rm_command='rm run/'+prod_tag+"_"+date+'/100xxx/'+dsid+'/*.*'
    
    os.system(rm_command)

    mkdir_command='mkdir -p run/'+prod_tag+"_"+date+'/100xxx/'+dsid
    os.system(mkdir_command)

    cp_JO='cp 100xxx/'+dsid+'/* run/'+prod_tag+"_"+date+'/100xxx/'+dsid
    os.system(cp_JO)

    cp_MGControl='cp -r 100xxx/100800 run/'+prod_tag+"_"+date+'/100xxx/'
    os.system(cp_MGControl)

    parent_dir = os.getcwd()

    run_dir='run/'+prod_tag+"_"+date
    os.chdir(run_dir)

    ls='ls ./*'
    os.system(ls)

    command_to_run='pathena --trf "Gen_tf.py --ecmEnergy='+str(ecmEnergy)+' --jobConfig='+str(dsid)+' --maxEvents='+str(nevents)+' --randomSeed='+str(seed)+' --outputEVNTFile %OUT.EVNT.root" --outDS user.'+user+'.gen_hbsm4tops-mg_'+prod_tag+'_'+date+' --split '+str(split)+' --memory=4096 -y'
    self.os_run(command_to_run)

    os.chdir(parent_dir)