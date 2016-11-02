# library(ukpolice)
# context("Crime")
#
# crime_table_names <- c("category",
#                        "context",
#                        "id",
#                        "location_subtype",
#                        "location_type",
#                        "latitude",
#                        "longitude",
#                        "street_id",
#                        "street_name",
#                        "date",
#                        "persistent_id",
#                        "outcome_category",
#                        "outcome_date")
# c("category", "persistent_id", "not", "date", "latitude", "longitude", "street_id", "street_name", "context", "id", "location_type", "es", "location_subtype", "outcome_status")
#
# test_crime <- ukp_crime_street_point(lat = 52.629729,
#                                      lng = -1.131592)
#
# test_that("ukp_crime_street_point has appropriate names", {
#   testthat::expect_is(object = test_crime , class = "tbl_df")
#   testthat::expect_named(object = test_crime, expected = crime_table_names)
# })
