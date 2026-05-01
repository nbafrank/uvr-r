test_that("update_uvr works", {
  path <- setup_uvr_test() # installs uvr if needed

  expect_no_error(update_uvr())

  # TODO: test other `ref` and `method` values
})
