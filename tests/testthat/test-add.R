test_that("add works and errors on empty packages", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed

  # Case: add single package to .toml only
  expect_no_error(add(
    "jsonlite",
    bin = path,
    dir = temp_dir,
    do_lock = FALSE,
    quiet = TRUE
  ))
  toml <- readLines(file.path(temp_dir, "uvr.toml"))
  expect_true(any(grepl('jsonlite = "\\*"', toml)))
  expect_false(file.exists(file.path(temp_dir, "uvr.lock")))

  # Case: add single package w/ specific version to .toml and .lock.
  # uvr only resolves versions in the live CRAN index, so pin the version
  # it just resolved rather than hardcoding one that will fall out of date.
  add(
    "jsonlite",
    bin = path,
    dir = temp_dir,
    do_install = FALSE,
    quiet = TRUE
  )
  current <- locked_version(temp_dir, "jsonlite")
  expect_false(is.na(current))
  expect_no_error(add(
    paste0("jsonlite@", current),
    bin = path,
    dir = temp_dir,
    do_install = FALSE,
    quiet = TRUE
  ))
  toml <- readLines(file.path(temp_dir, "uvr.toml"))
  expect_true(any(grepl(
    sprintf('jsonlite = "%s"', current),
    toml,
    fixed = TRUE
  )))
  expect_identical(locked_version(temp_dir, "jsonlite"), current)

  # Case: add github repo with mismatch pkgname/repo name
  # (i.e. nbafrank/uvr-r -> package `uvr`)
  expect_no_error(
    add(
      "nbafrank/uvr-r",
      bin = path,
      dir = temp_dir,
      do_install = FALSE,
      quiet = TRUE
    )
  )
  toml <- paste(readLines(file.path(temp_dir, "uvr.toml")), collapse = "\n")
  expect_match(toml, "uvr", fixed = TRUE)
  expect_match(toml, 'git = "nbafrank/uvr-r"', fixed = TRUE)
  lock <- paste(readLines(file.path(temp_dir, "uvr.lock")), collapse = "\n")
  expect_match(lock, 'name = "uvr"', fixed = TRUE)
  expect_match(lock, 'source = "github"', fixed = TRUE)

  # Case: empty packages argument errors
  expect_error(
    add(character(0), quiet = TRUE),
    "must be a non-NA character vector with length > 0"
  )
})
