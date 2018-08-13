#!/bin/bash
#bash 魚種担当.bash
FNAME='output/TW_Engraulis-japonicus_nenrei_seichou.tex'
#FNAME2='output/TW_Engraulis-japonicus_nenrei_seichou.txt'
cat ${FNAME} |  awk '{print substr($0, index($0, "\digest{"), index($0, "}") -1)}'
