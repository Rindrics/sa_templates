#!/bin/bash
#bash MakeTables.bash
#R CMD BATCH --vanilla DT.R
#PDF=*.pdf
#PNG=*.png
#for i in `seq 1 3`
#do
#   figdir=../../../Output/StockAssess/Fig/Chap$i
#   files=$figdir/*.eps
#   for j in $files
#   do
#     pstopdf $j
#     rm $j
#   done
# done
# for i in `seq 1 3`
# do
#   figdir=../../Output/DT/Fig/Chap$i
#   extractbb $figdir/$PDF
#   extractbb $figdir/$PNG
# done
#for f in 1st 2nd 3rd final; do
#  echo "-------------$f try---------------------"
#  ptex2pdf -l -shell-escape $1 < /dev/null|| exit 1
#  grep 'Rerun to get cross-references right.' ${1%.tex}.log || exit 0;
#done
bash replace.bash
  ptex2pdf -l texProposal
  escape texProposal
  open texProposal.pdf
