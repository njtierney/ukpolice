library(ukpolice)
context("Crime")

crime_table_names <- c("category",
                       "persistent_id",
                       "date",
                       "latitude",
                       "longitude",
                       "street_id",
                       "street_name",
                       "context",
                       "id",
                       "location_type",
                       "location_subtype",
                       "outcome_status")

test_crime <- ukp_crime(lat = 52.629729, lng = -1.131592)

test_that("ukp_crime has appropriate names", {
  testthat::expect_is(object = test_crime , class = "tbl_df")
  testthat::expect_named(object = test_crime, expected = crime_table_names)
})

test_date_number <- "2016-03"

test_crime_date <- ukp_crime(lat = 52.629729,
                             lng = -1.131592,
                             date = test_date_number)

test_that("ukp_crime measures date appropriately", {
  testthat::expect_equal(object = test_crime_date$date[1],
                         expected = test_date_number)
})

# with 3 points
ukp_data_poly_3 <- ukp_crime_poly(
poly = c("52.268, 0.543:52.794,0.238:52.130,0.478")
)

test_that("ukp_crime_poly is a tibble", {
  testthat::expect_is(ukp_data_poly_3, "tbl_df")
})

ukp_data_poly_4 <- ukp_crime_poly(
  poly = c("52.268, 0.543:52.794,0.238:52.130,0.478:52.000,0.400")
)

test_that("ukp_crime_poly works for four points", {
  testthat::expect_is(ukp_data_poly_4, "tbl_df")
})
