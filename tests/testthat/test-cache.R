test_that("cache_clean works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(cache_clean(cache_dir = cache_dir, bin = path, quiet = TRUE))
})

test_that("cache files are created where expected (#21)", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  cache_dir <- file.path(temp_dir, ".uvr-test-cache")
  packages_dir <- file.path(temp_dir, ".uvr-test-packages")
  withr::local_envvar(UVR_PACKAGES_DIR = packages_dir)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)

  sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)

  # Installed-package entries land under UVR_PACKAGES_DIR, keyed by name
  expect_true(dir.exists(packages_dir))
  expect_true(
    length(list.files(packages_dir, pattern = "^jsonlite-")) > 0
  )
  # The download cache directory is created at the configured location
  expect_true(dir.exists(cache_dir))
})

test_that("filtered cache_clean removes only what matches (#21, #92)", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  cache_dir <- file.path(temp_dir, ".uvr-test-cache")
  packages_dir <- file.path(temp_dir, ".uvr-test-packages")
  withr::local_envvar(UVR_PACKAGES_DIR = packages_dir)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)
  sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)

  # A non-matching filter must leave the cache untouched
  cache_clean(
    package = "not-a-real-package",
    cache_dir = cache_dir,
    bin = path,
    quiet = TRUE
  )
  expect_true(
    length(list.files(packages_dir, pattern = "^jsonlite-")) > 0
  )

  # A matching filter removes exactly that package's entries
  cache_clean(
    package = "jsonlite",
    cache_dir = cache_dir,
    bin = path,
    quiet = TRUE
  )
  expect_identical(
    list.files(packages_dir, pattern = "^jsonlite-"),
    character(0)
  )
})

test_that("full cache_clean empties the download cache (#21)", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  cache_dir <- file.path(temp_dir, ".uvr-test-cache")
  packages_dir <- file.path(temp_dir, ".uvr-test-packages")
  withr::local_envvar(UVR_PACKAGES_DIR = packages_dir)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)
  sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)

  cache_clean(cache_dir = cache_dir, bin = path, quiet = TRUE)
  leftover <- list.files(cache_dir, recursive = TRUE)
  expect_identical(leftover, character(0))
  expect_identical(
    list.files(packages_dir, pattern = "^jsonlite-"),
    character(0)
  )
})
