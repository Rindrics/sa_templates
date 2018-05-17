library(XLConnect)
WB      <- loadWorkbook("../DIGEST.xlsx")
SHEETS  <- getSheets(WB)
HONBUN  <- readWorksheet(WB,sheet=SHEETS[1], header=F)
COLPOS_THISYEAR     <- 4
SPCS_NAME_JP        <- HONBUN[ 4,2]
SCIENTIFIC_NAME     <- HONBUN[ 5,2]
STOCK_NAME          <- HONBUN[ 6,2]
TANTOUSUIKEN        <- HONBUN[ 7,2]
TANTOUSHA           <- HONBUN[ 8,2]
LIFESPAN            <- HONBUN[11,COLPOS_THISYEAR]
AGE_AT_1ST_MATURITY <- HONBUN[12,COLPOS_THISYEAR]
SPAWNING_SEAS_GRD   <- HONBUN[13,COLPOS_THISYEAR]
FORAGING_SEAS_GRD   <- HONBUN[14,COLPOS_THISYEAR]
FEEDING_ECOLOGY     <- HONBUN[15,COLPOS_THISYEAR]
PREDATOR            <- HONBUN[16,COLPOS_THISYEAR]
CSSDIR_SCR          <- "../cmn/scr_style.css" #柳田さん環境
CSSDIR_PRT          <- "../cmn/prt_style.css" #柳田さん環境
CSSDIR_SCR          <- "scr_style.css"
CSSDIR_PRT          <- "prt_style.css"

PAGEINFO <- "<html>
<head>
<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\">
<title>SPCS_NAME_JP STOCK_NAMEダイジェスト版</title>
<link rel=\"Stylesheet\" type=\"text/css\" href=\"CSSDIR_SCR\">
<link rel=\"Stylesheet\" type=\"text/css\" href=\"CSSDIR_PRT\" media=\"print\">

<script type=\"text/javascript\">
var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");
document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));
</script>
<script type=\"text/javascript\">
var pageTracker = _gat._getTracker(\"UA-4451830-1\");
pageTracker._initData();
pageTracker._trackPageview();
</script>
"

HEADER <- "</head>
  <body>
  <a name=\"top\">
  <div class=\"hyouka_card\">
  
  <h1>平成２８年度資源評価報告書（ダイジェスト版）</h1>
  <p id=\"breadcrumbs_navi\">
  <a href=\"../../index.html\">Top</a> &gt;<a href=\"../../index1.html\">資源評価</a>&gt; <a href=\"../index.html\">平成28年度資源評価</a>  &gt; ダイジェスト版
</p>
  <div class=\"to_details\"><a href=\"../details/2803.pdf\">［詳細版へ］</a></div>
  <table class=\"1-1\" border=\"0\" cellspacing=\"1\" cellpaddint=\"4\">
  <tr>
  <td>標準和名
<td width=\"240\"><span  class=\"wamei\">SPCS_NAME_JP </span></td>
  <td rowspan=\"4\"><img class=\"photo\" src=\"../fig/2803.jpg\" alt=\"魚種写真\"></td>
  </tr>
  <tr>
  <td>学名</td>
  <td><span class=\"gakumei\">SCIENTIFIC_NAME</span></td>
  </tr>
  <tr>
  <td>系群名</td>
  <td><span class=\"keigun\">STOCK_NAME</span></td>
  </tr>
  <tr>
  <td>担当水研</td>
  <td><span class=\"tantou\">TANTOUSUIKEN</span></td>
  </tr>
  </table>
  "
BIOLOGY <- "<div class=\"chapter\">
<h2>生物学的特性</h2>
<table class=\"1-2\" cellpadding=\"0\" border=\"0\" cellspacing=\"1\" cellpaddint=\"4\">
<tr>
<td width=\"150\"><span class=\"tokusei\">寿命：</span></td>
<td width=\"640\"><span class=\"tokusei\">LIFESPAN</span></td>
</tr>
<tr>
<td><span class=\"tokusei\">成熟開始年齢：</span></td>
<td><span class=\"tokusei\">AGE_AT_1ST_MATURITY</span></td>
</tr>
<tr>
<td valign=\"top\"><span class=\"tokusei\">産卵期・産卵場：</span></td>
<td><span class=\"tokusei\">SPAWNING_SEAS_GRD</td>
</tr>
<tr>
<td><span class=\"tokusei\">食性：</span></td>
<td><span class=\"tokusei\">FORAGING_SEAS_GRD</span></td>
</tr>
<tr>
<td><span class=\"tokusei\">捕食者：</td>
<td><span class=\"tokusei\">PREDATOR</span></td>
</tr>
</table>


<a href=\"../fig/2803.png\"><img class=\"fig\" src=\"../fig/2803.png\"></a>
<a href=\"../fig/2803-01.png\"><img class=\"fig\" src=\"../fig/2803-01.png\"></a>
</div>

<p class=\"totop\">
<a href=\"#top\">▲このページのＴＯＰへ</a>
</p>
"


END <- "</body>
  </html>"

OUTPUT <- paste(PAGEINFO, HEADER, BIOLOGY, END)
OUTPUT <- gsub("SPCS_NAME_JP ", SPCS_NAME_JP,
          gsub("STOCK_NAME", STOCK_NAME,
          gsub("SCIENTIFIC_NAME", SCIENTIFIC_NAME,
          gsub("LIFESPAN", LIFESPAN,
          gsub("AGE_AT_1ST_MATURITY", AGE_AT_1ST_MATURITY,
          gsub("SPAWNING_SEAS_GRD", SPAWNING_SEAS_GRD,
          gsub("FORAGING_SEAS_GRD", FORAGING_SEAS_GRD,
          gsub("FEEDING_ECOLOGY", FEEDING_ECOLOGY,
          gsub("PREDATOR", PREDATOR,
          # gsub("",,
          # gsub("",,
          # gsub("",,
          # gsub("",,
          # gsub("",,
          # gsub("",,
          #      gsub("",,
          #           gsub("",,
          #                gsub("",,
          #                     gsub("",,
          #                          gsub("",,
          #                               gsub("",,
          gsub("CSSDIR_SCR",CSSDIR_SCR,
          gsub("CSSDIR_PRT",CSSDIR_PRT,OUTPUT)))))))))))
write.table(OUTPUT, paste("../output/", SPCS_NAME_JP, ".html", sep=""),row.names = F, col.names = F, quote = F)
