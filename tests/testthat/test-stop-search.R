context("test-stop-search")

test_stop_search <- ukp_stop_search(lat = 52.629729, lng = -1.131592)

stop_search_table_names <- c("type",
                             "involved_person",
                             "datetime",
                             "lat",
                             "long",
                             "street_id",
                             "street_name",
                             "age_range",
                             "gender",
                             "legislation",
                             "object_of_search",
                             "officer_defined_ethnicity",
                             "outcome",
                             "outcome_linked_to_object_of_search",
                             "outcome_object_id",
                             "outcome_object_name",
                             "removal_of_more_than_outer_clothing",
                             "self_defined_ethnicity")


test_that("ukp_stop_search has appropriate names", {
  testthat::expect_is(object = test_stop_search , class = "tbl_df")
  testthat::expect_named(object = test_stop_search,
                         expected = stop_search_table_names)
})

test_date_number <- "2016-03-12T00:28:00+00:00"
test_date <- "2016-03"

test_stop_search_date <- ukp_stop_search(lat = 52.629729,
                             lng = -1.131592,
                             date = test_date)

test_that("ukp_stop_search measures date appropriately", {
  testthat::expect_equal(object = test_stop_search_date$datetime[1],
                         expected = test_date_number)
})

test_that("ukp_stop_search returns lat and long that are numeric", {
  testthat::expect_is(object = test_stop_search_date$long,
                      class = "numeric")
  testthat::expect_is(object = test_stop_search_date$lat,
                      class = "numeric")
})

# with 3 points
poly_df_3 <- data.frame(lat = c(52.268, 52.794, 52.130),
                        long = c(0.543, 0.238, 0.478))

ukp_data_poly_3 <- ukp_stop_search_poly(poly_df_3)


test_that("ukp_stop_search_poly is a tibble", {
  testthat::expect_is(ukp_data_poly_3, "tbl_df")
})

test_that("ukp_stop_search_poly returns lat and long that are numeric", {
  testthat::expect_is(object = ukp_data_poly_3$long,
                      class = "numeric")
  testthat::expect_is(object = ukp_data_poly_3$lat,
                      class = "numeric")
})

# with 4 points
poly_df_4 <- data.frame(lat = c(52.268, 52.794, 52.130, 52.000),
                        long = c(0.543,  0.238,  0.478,  0.400))

ukp_data_poly_4 <- ukp_stop_search_poly(poly_df = poly_df_4)


test_that("ukp_stop_search_poly works for four points", {
  testthat::expect_is(ukp_data_poly_4, "tbl_df")
})
