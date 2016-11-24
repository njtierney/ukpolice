library(ukpolice)
context("Neighbourhoods")

test_neighbours <- ukp_neighbourhood("leicestershire")
test_neighbour_force <- ukp_neighbourhood_location(c("51.500617,-0.124629"))

test_that("ukp_neighbourhood_* returns a tibble", {
  testthat::expect_is(object = test_neighbours, class = "tbl_df")
  testthat::expect_is(object = test_neighbour_force, class = "tbl_df")
})

test_that("ukp_neighbourhoods returns two columns named 'id' and 'name'",{
  testthat::expect_named(test_neighbours, expected = c("id", "name"))
})

test_that("ukp_neighbourhood_team returns columns 'force' and 'neighbourhood'",{
  testthat::expect_named(test_neighbour_force,
                         expected = c("force", "neighbourhood"))

})
