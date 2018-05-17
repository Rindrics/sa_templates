targetPackages	<- c('hash') 
newPackages			<- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages)) install.packages(newPackages, repos = "http://cran.us.r-project.org")
for(package in targetPackages) library(package, character.only = T)
source("定数.R")

CONTROLEFILEDIR <- "../controllingFiles/"
CONTROLEFILES   <- list.files(CONTROLEFILEDIR, pattern = ".+\\.[tex]|[bib]")
EDITFILEDIR     <- "../編集用ファイル/"
EDITFILES       <- list.files(EDITFILEDIR, pattern = ".+\\.[tex]|[bib]")
FIGDIR          <- "../図/"
FIGURES         <- list.files(FIGDIR)
FILENAME_DATA   <- read.csv("FnameTable.csv", stringsAsFactors = F)
FILENAME_TBL    <- hash(FILENAME_DATA$JapaneseFname, FILENAME_DATA$EglishFname)
for(i in EDITFILES){
  english_fname <- FILENAME_TBL[[as.character(i)]]
	newfilename   <- paste(STOCK_ABB, SPCS_NAME, english_fname, sep="_")
	contents_org  <- scan(paste(EDITFILEDIR,i,sep=""), what = character(), sep = "\n", blank.lines.skip = F)
	contents_new  <- contents_org
  contents_new  <- gsub("\\{output/", paste("\\{output/", STOCK_ABB,"_", SPCS_NAME, "_", sep=""), contents_new)
	writeLines(contents_new, paste("../output/",newfilename, sep=""))
}
for(i in CONTROLEFILES){
  contents_org  <- scan(paste(CONTROLEFILEDIR,i,sep=""), what = character(), sep = "\n", blank.lines.skip = F)
  contents_new  <- contents_org
  contents_new  <- gsub("input\\{output/", paste("input\\{output/", STOCK_ABB,"_", SPCS_NAME, "_", sep=""), contents_new)
  contents_new  <- gsub("SPCSNAMEJP", SPCS_NAME_JP, gsub("STOCKABBJP",STOCK_ABB_JP, contents_new))
  contents_new  <- gsub("output/references", paste("output/", STOCK_ABB,"_", SPCS_NAME, "_references", sep=""), contents_new)
  newfilename   <- paste(STOCK_ABB, SPCS_NAME, i, sep="_")
  writeLines(contents_new, paste("../output/",newfilename, sep=""))
}
for(i in FIGURES){
  newfilename   <- paste(STOCK_ABB, SPCS_NAME, i, sep="_")
  file.copy(paste(FIGDIR, i, sep=""), paste("../output/",newfilename, sep=""), overwrite = T)
}


# write.table(JPNAME_FILES, "FnameTable.csv", row.names = F, col.names = F, fileEncoding = "UTF-8")

