source ./setup.sh
export RIVET_ANALYSIS_PATH=./rivet
#rivet-merge -o plot/100806ttZsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.476 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100806_13600GeV_248349/Rivet.yoda.gz:0.524
#rivet-merge -o plot/100807ttZsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.723 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100807_13600GeV_442584/Rivet.yoda.gz:0.277
#rivet-merge -o plot/100808ttZsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.872 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100808_13600GeV_210473/Rivet.yoda.gz:0.128
#rivet-merge -o plot/100809ttZsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.982 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100809_13600GeV_174613/Rivet.yoda.gz:0.018

#rivet-merge -o plot/100874ttZstsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.396 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100874_13600GeV_156158/Rivet.yoda.gz:0.604
#rivet-merge -o plot/100871ttZstsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.650 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100871_13600GeV_217815/Rivet.yoda.gz:0.350
#rivet-merge -o plot/100872ttZstsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.824 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100872_13600GeV_240171/Rivet.yoda.gz:0.176
#rivet-merge -o plot/100809ttZstsm.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.961 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100809_13600GeV_174613/Rivet.yoda.gz:0.039

#rivet-merge -o plot/100874ttZstsm_diff.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz:0.511 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100874_13600GeV_156158/Rivet.yoda.gz:0.489 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100881_13600GeV_178728/Rivet.yoda.gz:-1

rivet-merge -o plot/100874ttZstsmfilter.yoda.gz  /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100108_13600GeV_446377/Rivet.yoda.gz:0.469685 /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100874_13600GeV_156158/Rivet.yoda.gz:0.530315


#rivet-mkhtml --errs --no-weights  -o plot/100806ttZsm_plots plot/100806ttZsm.yoda.gz:"Title=1000 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100881_13600GeV_178728/Rivet.yoda.gz:"Title=1000 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100807ttZsm_plots plot/100807ttZsm.yoda.gz:"Title=1250 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100882_13600GeV_132706/Rivet.yoda.gz:"Title=1250 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100808ttZsm_plots plot/100808ttZsm.yoda.gz:"Title=1500 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100883_13600GeV_491817/Rivet.yoda.gz:"Title=1500 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100809ttZsm_plots plot/100809ttZsm.yoda.gz:"Title=2000 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100884_13600GeV_444776/Rivet.yoda.gz:"Title=2000 (BSM+SM)"

#rivet-mkhtml --errs --no-weights  -o plot/100874ttZstsm_plots plot/100874ttZstsm.yoda.gz:"Title=1000 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100881_13600GeV_178728/Rivet.yoda.gz:"Title=1000 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100871ttZstsm_plots plot/100871ttZstsm.yoda.gz:"Title=1250 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100882_13600GeV_132706/Rivet.yoda.gz:"Title=1250 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100872ttZstsm_plots plot/100872ttZstsm.yoda.gz:"Title=1500 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100883_13600GeV_491817/Rivet.yoda.gz:"Title=1500 (BSM+SM)"
#rivet-mkhtml --errs --no-weights  -o plot/100809ttZstsm_plots plot/100809ttZsm.yoda.gz:"Title=2000 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100884_13600GeV_444776/Rivet.yoda.gz:"Title=2000 (BSM+SM)"

#rivet-mkhtml --errs --no-weights  -o plot/100874ttZsm_plots_diff plot/100874ttZstsm_diff.yoda.gz:"Title=1000 (BSM)+(SM)-(BSM+SM)" 

#rivet-mkhtml --errs --no-weights  -o plot/1000SM_ttZ_plots /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100806_13600GeV_248349/Rivet.yoda.gz:"Title=1000 BSM s+t" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100104_13600GeV_298268/Rivet.yoda.gz"Title=1000 SM"
rivet-mkhtml --errs --no-weights  -o plot/100874ttZstsmfilter_plots plot/100874ttZstsmfilter.yoda.gz:"Title=1000 (BSM)+(SM)" /eos/user/r/rqian/atlas-run3-multitops-bsm-joboptions/output/100881_13600GeV_178728/Rivet.yoda.gz:"Title=1000 (BSM+SM)"