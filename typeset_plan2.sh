
platex ./fish1
pbibtex ./fish1
platex ./fish1
platex ./fish1
dvipdfmx ./fish1
platex ./fish2
pbibtex ./fish2
platex ./fish2
platex ./fish2
dvipdfmx ./fish2
platex ./master_plan2
dvipdfmx ./master_plan2
open -a Skim ./master_plan2.pdf
