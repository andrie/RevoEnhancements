# Test For the rxLinPredError() function
rxOptions(reportProgress=0)

context("rxLinPredError")

test_that("rxLinPredError works with data frame",{
  dat <- data.frame(actual = c(1.264896, 1.964210, 2.671872, 3.838703, 5.252300), 
                   pred = 1:5, weights = rep(1, 5))
  tst <- rxLinPredError("actual", "pred", dat, "weights", reportProgress=0)
  expect_is(tst, "list")
  expect_equal(names(tst), c("MAPE", "MPE",  "MSE",  "MSWD"))
  expect_equivalent(unname(unlist(tst)), c(0.08810105, -0.01488186,  0.05375816,  1.07516325))
})

test_that("rxLinPredError works with XDF",{
  dataFile <- tempfile(pattern = ".data", fileext = ".xdf")
  on.exit({
    file.remove(dataFile) 
  })
  dat <- data.frame(actual = c(1.264896, 1.964210, 2.671872, 3.838703, 5.252300), 
                   pred = 1:5, weights = rep(1, 5))
  rxDataStep(dat, outFile=dataFile, rowsPerRead=50, reportProgress=0)
  tst <- rxLinPredError("actual", "pred", dataFile, "weights", reportProgress=0)
  expect_is(tst, "list")
  expect_equal(names(tst), c("MAPE", "MPE",  "MSE",  "MSWD"))
  expect_equivalent(unname(unlist(tst)), c(0.08810105, -0.01488186,  0.05375816,  1.07516325))
})

