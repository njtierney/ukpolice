library(ukpolice)
context("Utils ukp_last_update")

test_last_update <- ukp_last_update()

test_that("ukp_last_update is a character", {
  testthat::expect_is(object = test_last_update, class = "character")
  testthat::expect_equal(object =  nchar(test_last_update), expected = 7)
})
