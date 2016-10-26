library(ukpolice)
context("Neighbourhoods")

test_neighbours <- get_neighbourhoods("leicestershire")

test_that("get_neighbourhoods returns a tibble", {
  testthat::expect_is(object = test_neighbours, class = "tbl_df")
})

test_that("get_neighbourhoods returns two columns named 'id' and 'name'",{
  testthat::expect_named(test_neighbours, expected = c("id", "name"))
})
