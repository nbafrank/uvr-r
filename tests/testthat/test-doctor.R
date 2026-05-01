test_that("doctor works", {
  path <- setup_uvr_test() # installs uvr if needed

  expect_no_error(doctor(bin = path))
})
