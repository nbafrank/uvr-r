test_that("sync works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(
    sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)
  )
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))

  # Case: ignore_cache = TRUE
  unlink(file.path(temp_dir, ".uvr/library/jsonlite"), recursive = TRUE)
  result <- sync(
    bin = path,
    dir = temp_dir,
    cache_dir = cache_dir,
    quiet = TRUE
  )
  expect_match(paste(result, collapse = "\n"), "100% cache hit")
  unlink(file.path(temp_dir, ".uvr/library/jsonlite"), recursive = TRUE)
  result <- expect_no_error(
    sync(
      bin = path,
      dir = temp_dir,
      cache_dir = cache_dir,
      ignore_cache = TRUE,
      quiet = TRUE
    )
  )
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))
  expect_match(paste(result, collapse = "\n"), " 0% cache hit")
})
