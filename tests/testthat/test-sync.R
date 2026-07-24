test_that("sync works", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(
    sync(bin = path, dir = temp_dir, cache_dir = cache_dir, quiet = TRUE)
  )
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))
})

test_that("sync(frozen = TRUE) installs from an up-to-date lockfile (#22)", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  expect_no_error(
    sync(
      frozen = TRUE,
      bin = path,
      dir = temp_dir,
      cache_dir = cache_dir,
      quiet = TRUE
    )
  )
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))
})

test_that("sync(frozen = TRUE) fails when the lockfile is out of date (#22)", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE)

  # Manifest-only change: lockfile no longer reflects uvr.toml
  add(
    "digest",
    do_lock = FALSE,
    bin = path,
    dir = temp_dir,
    quiet = TRUE
  )
  expect_error(
    sync(frozen = TRUE, bin = path, dir = temp_dir, quiet = TRUE),
    "uvr exited with code"
  )
})

test_that("sync over several dependencies works with forced progress (#24)", {
  # The spinner itself is drawn by the CLI; from R uvr's output is captured
  # through processx pipes (never a TTY), so progress is normally hidden.
  # progress = "always" forces the spinner codes through those pipes — this
  # test proves a multi-package sync neither hangs nor corrupts the stream
  # when it is on.
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE)
  add(
    c("jsonlite", "digest", "base64enc"),
    do_install = FALSE,
    bin = path,
    dir = temp_dir,
    quiet = TRUE
  )

  cache_dir <- file.path(temp_dir, ".uvr/cache")
  output <- sync(
    bin = path,
    dir = temp_dir,
    cache_dir = cache_dir,
    progress = "always",
    quiet = TRUE
  )
  for (pkg in c("jsonlite", "digest", "base64enc")) {
    expect_true(dir.exists(file.path(temp_dir, ".uvr/library", pkg)))
  }
  expect_true(length(output) > 0)
})
