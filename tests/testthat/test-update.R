test_that("update_uvr works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(update_uvr())

  # TODO: test other `ref` and `method` values
})
