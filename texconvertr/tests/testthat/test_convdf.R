context("convert data frame into LaTeX table")

test_that("make_header() makes header", {
  df <- data.frame(a = 1:3, b = 2:4)
  expect_equal(make_header(df), "a & b \\ \\hline")
})
