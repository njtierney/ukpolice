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

test_crime <- ukp_crime_street_point(lat = 52.629729,
                                     lng = -1.131592)

test_that("ukp_crime_street_point has appropriate names", {
  testthat::expect_is(object = test_crime , class = "tbl_df")
  testthat::expect_named(object = test_crime, expected = crime_table_names)
})

test_date_number <- "2016-03"

test_crime_date <- ukp_crime_street_point(lat = 52.629729,
                                          lng = -1.131592,
                                          date = test_date_number)

test_that("ukp_crime_street_point measures date appropriately", {
  testthat::expect_equal(object = test_crime_date$date[1],
                         expected = test_date_number)
})

