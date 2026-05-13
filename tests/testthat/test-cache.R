test_that("cache_clean works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  expect_no_error(cache_clean(bin = path, quiet = TRUE)) # TODO: prevent side effects
})
