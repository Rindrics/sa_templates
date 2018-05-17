#!/bin/bash
#bash 魚種担当.bash

#STOCK_ABBREVIATION='TW' # 			イニシャル2文字で命名
#SPCS_NAME='Engraulis-japonicus' # 	属名-種小名の形に書き換え
PDF='*.pdf'
PNG='*.png'
FIGDIR='./output'
extractbb ${FIGDIR}/${PDF}
#extractbb ${FIGDIR}/${PNG}

#bash CopyNecessities.bash
#rm output/*
#bash JPFname_to_EN_copy.bash
#R --slave --vanilla < R4TeX/ターミナルから一括実行.R
#ここから系群_種名をファイル名に追加
#for i in `ls output`
#do
#	mv output/$i output/${STOCK_ABBREVIATION}_${SPCS_NAME}_$i
#done
#ここまで系群_種名をファイル名に追加
#ここからファイル提出
#for i in `ls output`
#do
#	cp output/$i `echo $i | sed "s/^/\\.\\.\\/\\.\\.\\/output\\//g"`
#done
#ここまでファイル提出

#ptex2pdf -l -shell-escape _StockAssess_${STOCK_ABBREVIATION}_${SPCS_NAME}
#pbibtex _${STOCK_ABBREVIATION}_${SPCS_NAME}
# bash replace_bbl.bash
#ptex2pdf -l -shell-escape _StockAssess_${STOCK_ABBREVIATION}_${SPCS_NAME}
#ptex2pdf -l -shell-escape _StockAssess_${STOCK_ABBREVIATION}_${SPCS_NAME}
#open _StockAssess_${STOCK_ABBREVIATION}_${SPCS_NAME}.pdf
