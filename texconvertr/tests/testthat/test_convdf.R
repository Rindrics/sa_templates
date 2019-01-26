context("convert data frame into LaTeX table")
df <- data.frame(a = 1:3, b = 2:4)
data("USArrests")

test_that("make_row() makes row", {
  expect_equal(make_row(colnames(df)), "a & b \\")
  expect_equal(make_row(df[1, ]), "1 & 2 \\")
  expect_equal(make_row(colnames(USArrests)),
               "Murder & Assault & UrbanPop & Rape \\")
  expect_equal(make_row(USArrests[1, ]), "13.2 & 236 & 58 & 21.2 \\")
})
