make_row <- function(x) {
  elements <- paste(x, collapse = " & ")
  eor     <- "\\"
  out     <- paste(elements, eor)
  out
}
