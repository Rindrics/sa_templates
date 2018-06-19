platex ./_TypesetMe
pbibtex ./PF_Engraulis-japonicus_nonTAC_1_withB
pbibtex ./TW_Engraulis-japonicus_nonTAC_1_withB
platex ./_TypesetMe
platex ./_TypesetMe
dvipdfmx ./_TypesetMe
open -a Skim ./_TypesetMe.pdf


