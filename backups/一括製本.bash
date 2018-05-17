#!/bin/bash
#bash 一括製本.bash
#R CMD BATCH --vanilla DT.R
PDF='*.pdf'
PNG='*.png'
FIGDIR='./fig'
extractbb ${FIGDIR}/${PDF}
extractbb ${FIGDIR}/${PNG}

#for f in 1st 2nd 3rd final
#do
#  echo "-------------$f try---------------------"
#  ptex2pdf -l -shell-escape $1 < /dev/null|| exit 1
#  grep 'Rerun to get cross-references right.' ${1%.tex}.log || exit 0;
#done
bash JPFname_to_EN.bash
ptex2pdf -l -shell-escape _StockAssess
pbibtex _TW_Engraulis-japonicus
# bash replace_bbl.bash
ptex2pdf -l -shell-escape _StockAssess
ptex2pdf -l -shell-escape _StockAssess
open _StockAssess.pdf
