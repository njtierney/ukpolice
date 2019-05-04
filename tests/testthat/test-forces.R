context("Forces")

forces_list_data <- ukp_list_forces()

test_that("forces returns the right number dimensions", {
  expect_equal(dim(forces_list_data), c(44,2))
})

test_that("forces returns the right column names", {
  expect_equal(names(forces_list_data),
               c("id", "name"))
})
