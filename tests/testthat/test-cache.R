test_that("cache_clean works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(cache_clean(cache_dir = cache_dir, bin = path, quiet = TRUE))
})
