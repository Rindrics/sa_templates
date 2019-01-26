make_header <- function(df) {
  name <- paste(colnames(df), collapse = " & ")
  eor  <- "\\ \\hline"
  out  <- paste(name, eor)
  out
}
