YEAR_START      <- THISYEAR - REVIEW_RANGE_yr + 1
YEARS           <- YEAR_START:THISYEAR
OUTFNAME        <- "output/youyaku_table_past5yr.tex"
ALLDATA         <- read.csv("編集用ファイル/過去5年間の資源量等.csv")
colnames(ALLDATA) <- c("Year","StockBiomass_ThousandTon","SSB_ThousandTon","Catch_ThousandTon","F","CatchRatio_percent")
DATA_FOR_TABLE  <- subset(ALLDATA, Year %in% YEARS); DATA_FOR_TABLE <- DATA_FOR_TABLE[order(DATA_FOR_TABLE$Year),]
out <- "\\過去五年間の資源量等"
for(i in 1:nrow(DATA_FOR_TABLE)){
  for(j in 1:ncol(DATA_FOR_TABLE)){
    ijdata <- DATA_FOR_TABLE[i,j]
    if(is.na(ijdata)==T){
      ijdata <- "--"
    }else if(j==5){# Fの列
      ijdata <- sprintf("%4.2f",ijdata)
    }
    if(j==1){
      newdata <- paste("{",ijdata," & ",sep="")
      # browser()
    }else if(j == ncol(DATA_FOR_TABLE)){
      newdata <- paste(ijdata,"}",sep="")
    }else{
      newdata <- paste(ijdata," & ",sep="")
    }
    out     <- paste(out, newdata, sep="")
  }
}
write.table(out,OUTFNAME, row.names = F, col.names = F,quote=F)