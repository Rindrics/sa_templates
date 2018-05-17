#!/bin/bash
#bash ファイルを集める.bash
SPCSNAMELIST=$(find ./ -maxdepth 1 -name "*-*" -type d|sed -e "s/.\\/\\///")
#echo $SPCSNAMELIST
for sp in ${SPCSNAMELIST}
do
stock_abb=$(find ./${sp} -maxdepth 1 -name "??" -type d|sed -e "s/.\\/${sp}\\///")
#    echo $sp
#    echo $stock_abb
    for st in ${stock_abb}
    do
    filedir=./${sp}/${st}/output
    filelist=$(ls ${filedir})
#    echo $filelist
        for f in ${filelist}
        do
            mv ${filedir}/${f} output/${st}_${sp}_${f}
        done
    done
#  echo $STOCKNAME
done
