test_that("sync works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(
    sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)
  )
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))
})
