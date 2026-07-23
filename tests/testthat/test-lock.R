# Note: uvr resolves against the live CRAN index, which only carries each
# package's current version — archived versions (e.g. jsonlite 1.8.8) are
# not resolvable. The #20 "old versions are held" behavior is therefore
# exercised through lock idempotence rather than by pinning an archived
# release.

test_that("lock works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed
  add(
    "jsonlite@>=1.8.0",
    do_lock = FALSE,
    bin = path,
    dir = temp_dir,
    quiet = TRUE
  )

  expect_no_error(lock(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))
  locked <- locked_version(temp_dir, "jsonlite")
  expect_false(is.na(locked))
  expect_true(package_version(locked) >= package_version("1.8.0"))
})

test_that("re-locking holds the locked versions (#20)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  add(
    "jsonlite@>=1.8.0",
    do_lock = FALSE,
    bin = path,
    dir = temp_dir,
    quiet = TRUE
  )
  lock(bin = path, dir = temp_dir, quiet = TRUE)
  lock_path <- file.path(temp_dir, "uvr.lock")
  first_lock <- readLines(lock_path)

  # A plain re-lock with an unchanged manifest must not move anything
  lock(bin = path, dir = temp_dir, quiet = TRUE)
  expect_identical(readLines(lock_path), first_lock)
})

test_that("lock(upgrade = TRUE) re-resolves without error (#20)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  add(
    "jsonlite@>=1.8.0",
    do_lock = FALSE,
    bin = path,
    dir = temp_dir,
    quiet = TRUE
  )
  lock(bin = path, dir = temp_dir, quiet = TRUE)
  before <- locked_version(temp_dir, "jsonlite")

  expect_no_error(
    lock(upgrade = TRUE, bin = path, dir = temp_dir, quiet = TRUE)
  )
  after <- locked_version(temp_dir, "jsonlite")
  expect_false(is.na(after))
  # Upgrade may only ever move forward
  expect_true(package_version(after) >= package_version(before))
})
