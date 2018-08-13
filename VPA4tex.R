source('rvpa1.9.r')
source('future1.10.r')
library(hash)
THIS_YEAR                       <- 2015
BLIMIT_ton                      <- 90901

M_LOW                           <- 0.4
M_MIDDLE                        <- 1.0
ALPHA                           <- 1
MAX_AGE                         <- 2
PCNT_SPR_REFFPONTS              <- seq(0, 100, 5)
YEAR_HEISEI_1ST                 <- 1988

  STOCK_LEVEL_LIST    <- c("HIGH", "LOW", "MID")
  STOCK_TREND_LIST    <- c("INCREASING", "DECREASING", "MAINTAINED")
STOCK_LEVEL         <- STOCK_LEVEL_LIST[3]
STOCK_TREND         <- STOCK_TREND_LIST[2]
  STOCK_LEVEL_TeXOUT  <- c("\\CID{02036}\\CID{01168}", "\\CID{03071}\\CID{01168}", "\\CID{02980}\\CID{01168}")
  STOCK_TREND_TeXOUT  <- c("\\CID{02815}\\CID{01347}", "\\CID{01902}\\CID{02455}", "\\CID{01315}\\CID{00889}\\CID{00845}")
  STOCK_LEVEL_TBL     <- hash(STOCK_LEVEL_LIST, STOCK_LEVEL_TeXOUT)
  STOCK_TREND_TBL     <- hash(STOCK_TREND_LIST, STOCK_TREND_TeXOUT)

INDIR     <-"../data"
OUTIDR    <-"../output"

TEXOUT_NEWCOMMAND <- "\\newcommand"
MAKEAT_HEAD       <- "\\makeatletter"
MAKEAT_TAIL       <- "\\makeatother"
tex_word_list     <- NULL
tex_macro_out     <- NULL

caa_hundred_thousand_fish <- read.csv(paste(INDIR,"/","caa_TW_Engraulis-japonicus.csv",sep=""), row.names=1)
caa                       <- caa_hundred_thousand_fish / 10
waa                       <- read.csv(paste(INDIR,"/","waa_TW_Engraulis-japonicus.csv",sep=""), row.names=1)
maa                       <- read.csv(paste(INDIR,"/","maa_TW_Engraulis-japonicus.csv",sep=""), row.names=1)
dat             <- data.handler(caa=caa, waa=waa, maa=maa, M=M_MIDDLE)
AGES            <- as.numeric(rownames(caa))

FIRST_YEAR      <- as.numeric(gsub("X", "", colnames(caa)[1]))
FCURRENT_YEAR   <- THIS_YEAR
PLOT_YEAR       <- FIRST_YEAR:(THIS_YEAR)
BYEAR           <- THIS_YEAR
TERMINALF_YEAR  <- (FCURRENT_YEAR-3):(FCURRENT_YEAR-1)
RPS_YEAR        <- (THIS_YEAR-10):(THIS_YEAR-1)
YEARS           <- FIRST_YEAR:THIS_YEAR
LAST_YEAR       <- THIS_YEAR-1
NEXT_YEAR       <- THIS_YEAR+1
ABC_YEAR        <- THIS_YEAR+2
THIS_YEAR_JP    <- THIS_YEAR - YEAR_HEISEI_1ST
LAST_YEAR_JP    <- LAST_YEAR - YEAR_HEISEI_1ST 
NEXT_YEAR_JP    <- NEXT_YEAR - YEAR_HEISEI_1ST

FUTURE_YEAR_MAX <- ABC_YEAR+4
FUTURE_YEARS    <- NEXT_YEAR:FUTURE_YEAR_MAX
RECENT_YEAR_REFERENCE_YR_BEFORE <- 4

#no tune
vout0<-vpa(dat,fc.year=FCURRENT_YEAR,tf.year = TERMINALF_YEAR, 
               ,Pope=TRUE,tune=FALSE,plus.group=FALSE, alpha=ALPHA, p.init=0.5, plot=TRUE, plot.year=PLOT_YEAR)
# rout <- ref.F(vout0,
#               waa.year  = BYEAR,
#               maa.year  = NULL,
#               M.year    = BYEAR,
#               rps.year  = RPS_YEAR,
#               max.age   = MAX_AGE,
#               pSPR      = PCNT_SPR_REFFPONTS,
#               Fspr.init = 0.2)
# fout <- future.vpa(vout0,
#                    currentF=NULL,
#                    multi=rout$summary$Fcur[3],
#                    nyear=15,start.year=THIS_YEAR+1,N=1000,
#                    ABC.year=THIS_YEAR+2,
#                    waa.year=byear,maa.year=NULL,M.year=byear,
#                    rec.new=r2017,
#                    recfunc=masaba.rec,
#                    rec.arg=list(rps.years=list(c(1976:2000,2012:2014),2001:2011),
#                                 rps.years.med=rps.year,
#                                 Blim.rec=221000,
#                                 bias.corrected=TRUE,
#                                 rpsmean=FALSE,
#                                 deterministic=FALSE,
#                                 upper.recruit=Inf))
BIOMASS_THISYEAR <- colSums(vout0$baa)[ncol(vout0$baa)]
BIOMASS_LASTYEAR <- colSums(vout0$baa)[ncol(vout0$baa)-1]
tex_word_list <- rbind(tex_word_list, cbind("ThisYr", THIS_YEAR))
tex_word_list <- rbind(tex_word_list, cbind("LastYr", LAST_YEAR))
tex_word_list <- rbind(tex_word_list, cbind("NextYr", NEXT_YEAR))
tex_word_list <- rbind(tex_word_list, cbind("ABCYr",  ABC_YEAR))
tex_word_list <- rbind(tex_word_list, cbind("ThisYrJp",  THIS_YEAR_JP))
tex_word_list <- rbind(tex_word_list, cbind("LastYrJp", LAST_YEAR_JP))
tex_word_list <- rbind(tex_word_list, cbind("NextYrJp", NEXT_YEAR_JP))
tex_word_list <- rbind(tex_word_list, cbind("RecentYr", paste(THIS_YEAR-RECENT_YEAR_REFERENCE_YR_BEFORE, "\\texttwelveudash", THIS_YEAR, sep="")))
tex_word_list <- rbind(tex_word_list, cbind("StockLevel", STOCK_LEVEL_TBL[[STOCK_LEVEL]]))
tex_word_list <- rbind(tex_word_list, cbind("StockTrend", STOCK_TREND_TBL[[STOCK_TREND]]))
tex_word_list <- rbind(tex_word_list, cbind("Alpha", ALPHA))
tex_macro_with_number <- NULL
for(i in 1:length(YEARS)){
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  if(i!=ncol(caa)){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{YearMinus", minus, "}{", year_minus_i, "}", MAKEAT_TAIL, sep=""))
  }
}
for(i in 1:length(YEARS)){
  j               <- i
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  j_caa           <- caa[, j] 
  total_catch_ton <- paste("{", format(as.numeric(sprintf("%.0f", sum(j_caa))), big.mark="{,}"), "\\CID{00964}\\CID{01007}}", sep="")
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_ton_", year_minus_i, "}", total_catch_ton, MAKEAT_TAIL, sep=""))
  if(year_minus_i==THIS_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_ton_THISYEAR}", total_catch_ton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==LAST_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_ton_LASTYEAR}", total_catch_ton, MAKEAT_TAIL, sep=""))
  }
}
for(i in 1:length(YEARS)){
  j               <- i
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  j_caa           <- caa[, j] 
  total_catch_thousandton <- paste("{", format(as.numeric(sprintf("%.0f", sum(j_caa)/1000)), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_thousandton_", year_minus_i, "}", total_catch_thousandton, MAKEAT_TAIL, sep=""))
  if(year_minus_i==THIS_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_thousandton_THISYEAR}", total_catch_thousandton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==LAST_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Catch_thousandton_LASTYEAR}", total_catch_thousandton, MAKEAT_TAIL, sep=""))
  }
}
# for(i in 1:(length(YEARS)-1)){
for(i in 1:length(YEARS)){
  j               <- i
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  j_baa           <- vout0$baa[, j] 
  total_biomass_ton       <- paste("{", format(as.numeric(sprintf("%.0f", sum(j_baa))), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Biomass_ton_", year_minus_i, "}", total_biomass_ton, MAKEAT_TAIL, sep=""))
  for(a in AGES){
    a_j_baa                     <- vout0$baa[a, j] 
    biomass_at_age_ton  <- paste("{", format(as.numeric(sprintf("%.0f", sum(a_j_baa))), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
    tex_macro_with_number       <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{BiomassAtAge_ton_AGE", a, "_", year_minus_i, "}", biomass_at_age_ton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==THIS_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Biomass_ton_THISYEAR}", total_biomass_ton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==LAST_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Biomass_ton_LASTYEAR}", total_biomass_ton, MAKEAT_TAIL, sep=""))
  }
}
# for(i in 1:(length(YEARS)-1)){
for(i in 1:length(YEARS)){
  j               <- i
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  j_baa           <- vout0$baa[, j] 
  total_biomass_thousandton <- paste("{", format(as.numeric(sprintf("%.0f", sum(j_baa)/1000)), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Biomass_thousandton_", year_minus_i, "}", total_biomass_thousandton, MAKEAT_TAIL, sep=""))
  for(a in AGES){
    a_j_baa                     <- vout0$baa[a, j] 
    biomass_at_age_thousandton  <- paste("{", format(as.numeric(sprintf("%.0f", sum(a_j_baa)/1000)), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
    tex_macro_with_number       <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{BiomassAtAge_thousandton_AGE", a, "_", year_minus_i, "}", biomass_at_age_thousandton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==THIS_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{Biomass_thousandton_THISYEAR}", total_biomass_thousandton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==LAST_YEAR){
    # tex_macro_with_number   <- rbind(tex_macro_with_number, "\\makeatletter")
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste("\\makeatletter\\@namedef{Biomass_thousandton_LASTYEAR}", total_biomass_thousandton,"\\makeatother", sep=""))
    # tex_macro_with_number   <- rbind(tex_macro_with_number, "\\makeatother")
  }
}
# for(i in 1:(length(YEARS)-1)){
for(i in 1:length(YEARS)){
  j               <- i
  minus           <- length(YEARS)-i
  year_minus_i    <- YEARS[i]
  j_ssb           <- vout0$ssb[, j] 
  total_ssb_thousandton <- paste("{", format(as.numeric(sprintf("%.0f", sum(j_ssb)/1000)), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{SSB_thousandton_", year_minus_i, "}", total_ssb_thousandton, MAKEAT_TAIL, sep=""))
  for(a in AGES){
    a_j_ssb                     <- vout0$ssb[a, j] 
    ssb_at_age_thousandton  <- paste("{", format(as.numeric(sprintf("%.0f", sum(a_j_ssb)/1000)), big.mark="{,}"), "\\CID{02701}\\CID{00964}\\CID{01007}}", sep="")
    tex_macro_with_number       <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{SSBAtAge_thousandton_AGE", a, "_", year_minus_i, "}", ssb_at_age_thousandton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==THIS_YEAR){
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{SSB_thousandton_THISYEAR}", total_ssb_thousandton, MAKEAT_TAIL, sep=""))
  }
  if(year_minus_i==LAST_YEAR){
    # tex_macro_with_number   <- rbind(tex_macro_with_number, "\\makeatletter")
    tex_macro_with_number   <- rbind(tex_macro_with_number, paste("\\makeatletter\\@namedef{SSB_thousandton_LASTYEAR}", total_ssb_thousandton,"\\makeatother", sep=""))
    # tex_macro_with_number   <- rbind(tex_macro_with_number, "\\makeatother")
  }
}
for(i in 1:length(FUTURE_YEARS)){
  j                       <- i
  plus                    <- i
  year_plus_i             <- FUTURE_YEARS[i]
  tex_macro_with_number   <- rbind(tex_macro_with_number, paste(MAKEAT_HEAD, "\\@namedef{YearPlus", plus, "}{", year_plus_i, "}", MAKEAT_TAIL, sep=""))
}
tex_macro_with_number   <- rbind(tex_macro_with_number, paste("\\makeatletter\\@namedef{Blimit_thousandton}{", sprintf('%.0f', BLIMIT_ton/1000),"\\CID{02701}\\CID{00964}\\CID{01007}}\\makeatother", sep=""))
tex_word_list           <- as.data.frame(tex_word_list)
colnames(tex_word_list) <- c("keyWord", "expandedCharacter")
for(i in 1:nrow(tex_word_list)){
  iwordlist <- tex_word_list[i, ]
  tex_macro_out <- rbind(tex_macro_out, paste(TEXOUT_NEWCOMMAND, "{\\", iwordlist$keyWord, "}", "{", iwordlist$expandedCharacter, "}", sep=""))
}
tex_macro_out <- rbind(tex_macro_out, tex_macro_with_number)
write.table(tex_macro_out, "../../stockAssess_TeX/Engraulis-japonicus/TW/TW_Engraulis-japonicus.sty", row.names=F, col.names=F, sep="", quote=F, fileEncoding="utf-8")
#par(mfrow=c(1,3))
  

#############   estimate b of winterings  #################################
# 
# vout <- vpa(dat=dat,
#                 sel.f=NULL,
#                 fc.year = 2012:2016,
#                 term.F="all",
#                 Pope=TRUE,
#                 rec.new  = r2017, 
#                 rec.year=2017, 
#                 last.catch.zero= TRUE,
#                 abund = c("B","SSB","N"),
#                 min.age = c(1,1,0),
#                 max.age = c(1,5,0),
#                 link = c("id","id","id"),
#                 tune=TRUE,
#                 p.init = c(0.5,0.5,0.5,0.5,0.5),
#                 est.method="ls",
#                 b.est=TRUE,
#                 b.fix=c(NA,1,1),
#                 plot=TRUE,
#                 plot.year=2007:2016)
# 
# 
# vout$faa$"2016"  
# vout$naa$"2015"  
# 
# saveRDS(vout,file=paste(OUTDIR,"/","vout.obj",sep=""))
# 
# 
# ####different M
# 
# dat0.3<- data.handler(caa, waa, maa, cpue, M=0.3)
# dat0.3$index["2007"][3,] <- NA
# 
# vout0.3 <- vpa(dat=dat0.3,
#             sel.f=NULL,
#             fc.year = 2012:2016,
#             term.F="all",
#             Pope=TRUE,
#             last.catch.zero= TRUE,
#             abund = c("B","SSB","N"),
#             min.age = c(1,1,0),
#             max.age = c(1,5,0),
#             link = c("id","id","id"),
#             tune=TRUE,
#             p.init = c(0.5,0.5,0.5,0.5,0.5),
#             est.method="ls",
#             b.est=TRUE,
#             b.fix=c(NA,1,1),
#             plot=TRUE,
#             plot.year=2007:2016)
# 
# dat0.5<- data.handler(caa, waa, maa, cpue, M=0.5)
# dat0.5$index["2007"][3,] <- NA
# 
# vout0.5 <- vpa(dat=dat0.5,
#                sel.f=NULL,
#                fc.year = 2012:2016,
#                term.F="all",
#                Pope=TRUE,
#                last.catch.zero= TRUE,
#                abund = c("B","SSB","N"),
#                min.age = c(1,1,0),
#                max.age = c(1,5,0),
#                link = c("id","id","id"),
#                tune=TRUE,
#                p.init = c(0.5,0.5,0.5,0.5,0.5),
#                est.method="ls",
#                b.est=TRUE,
#                b.fix=c(NA,1,1),
#                plot=TRUE,
#                plot.year=2007:2016)
# 
# saveRDS(vout0.3,file=paste(OUTDIR,"/","vout0.3.obj",sep=""))
# saveRDS(vout0.5,file=paste(OUTDIR,"/","vout0.5.obj",sep=""))
