context("ukp_geo_chull")

# identify the polygon you want to draw

poly_string <- ukp_geo_chull(data = york,
                             long = "long",
                             lat = "lat")

test_that("ukp_geo_chull returns a dataframe",{
  expect_s3_class(poly_string,
                  "data.frame")
})
