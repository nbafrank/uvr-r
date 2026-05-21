test_that("doctor works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(doctor(bin = path, quiet = TRUE))
})
