 #!/bin/bash
#file_to_var.bash

#行末の改行を削除
#変数に格納
youyaku=`cat youyaku.txt`
maegaki=`cat maegaki.txt`
bunpukaiyu=`cat bunpukaiyu.txt`
nenreiseichou=`cat nenreiseichou.txt`
seijukusanran=`cat seijukusanran.txt`
hihoshokukankei=`cat hihoshokukankei.txt`
zu=`cat zu.txt`

echo $youyaku

#texファイル生成
cat _ABC1-1の項目.txt | sed \
-e "s/ここに要約ファイルが読み込まれます/$youyaku/g" \
-e "s/ここにまえがきファイルが読み込まれます/$maegaki/g" \
-e "s/ここに分布・回遊ファイルが読み込まれます/$bunpukaiyu/g" \
-e "s/ここに年齢・成長ファイルが読み込まれます/$nenreiseichou/g" \
-e "s/ここに成熟・産卵ファイルが読み込まれます/$seijukusanran/g" \
-e "s/ここに非捕食関係ファイルが読み込まれます/$hihoshokukankei/g" \
-e "s/ここに図が読み込まれます/$zu/g" \
>semifinal.tex


cat semifinal.tex | sed \
-e "s/★改行/\\\par /g" \
-e "s/★%/\\\%/g" \
-e "s/★％/\\\%/g" \
-e "s/★中央揃え/\\\begin{center}/g" \
-e "s/中央揃え★/\\\end{center}/g" \
-e "s/★表を挿入/\\\input{/g" \
-e "s/表を挿入★/}/g" \
-e "s/★今年/\\\ThisFiscalYr /g" \
-e "s/★去年/\\\LastFiscalYr /g" \
-e "s/★来年/\\\NextFiscalYr /g" \
-e "s/★kotoshi/\\\ThisYrAD /g" \
-e "s/★kyonen/\\\LastYrAD /g" \
-e "s/★rainen/\\\NextYrAD /g" \
-e "s/髙/\\\CID{8705}/g" \
>final.tex
