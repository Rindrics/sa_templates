
platex ./master_plan1
pbibtex ./PF_Engraulis-japonicus_nonTAC_1_withB
pbibtex ./TW_Engraulis-japonicus_nonTAC_1_withB
platex ./master_plan1
platex ./master_plan1
dvipdfmx ./master_plan1
open -a Skim ./master_plan1.pdf
