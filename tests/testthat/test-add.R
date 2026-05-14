test_that("add works and errors on empty packages", {
  skip("waiting on 0.3.5 release of uvr with relevant fixes (--no-lock flag + uvr-r->uvr handling)")
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed

  # Case: add single package to .toml only
  expect_no_error(add(
    "jsonlite",
    bin = path,
    dir = temp_dir,
    do_lock = FALSE,
    quiet = TRUE
  ))
  readLines(file.path(temp_dir, "uvr.toml"))[-(1:3)] |>
    expect_identical(c("[dependencies]", "jsonlite = \"*\""))

  # Case: add single package w/ specific version to .toml and .lock
  expect_no_error(add(
    "jsonlite@2.0.0",
    bin = path,
    dir = temp_dir,
    do_install = FALSE,
    quiet = TRUE
  ))
  readLines(file.path(temp_dir, "uvr.toml"))[-(1:3)] |>
    expect_identical(c("[dependencies]", "jsonlite = \"2.0.0\""))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))
  readLines(file.path(temp_dir, "uvr.lock"))[-(1:3)] |>
    expect_identical(c(
      "[[package]]",
      "name = \"jsonlite\"",
      "version = \"2.0.0\"",
      "source = \"cran\"",
      "raw_version = \"2.0.0\"",
      "url = \"https://cran.r-project.org/src/contrib/jsonlite_2.0.0.tar.gz\"",
      "checksum = \"md5:3e54e6fbc0c9063936e3d01e91419c14\""
    ))

  # Case: add github repo with mismatch pkgname/repo name (i.e nbafrank/uvr-r -> uvr)
  expect_no_error(
    add(
      "nbafrank/uvr-r",
      bin = path,
      dir = temp_dir,
      do_lock = FALSE,
      quiet = TRUE
    )
  )
  readLines(file.path(temp_dir, "uvr.toml"))[-(1:6)] |>
    expect_identical(c(
      "[dependencies.uvr]",
      "git = \"nbafrank/uvr-r\""
    ))
  expect_true(file.exists(file.path(temp_dir, "uvr.lock")))
  lock_lines <- readLines(file.path(temp_dir, "uvr.lock"))
  # censor version numbers and checksums
  lock_lines[grepl("version", lock_lines)] <- lock_lines[
    grepl("version", lock_lines)
  ] |>
    gsub(pattern = "\\d", replacement = "x")
  lock_lines[grepl("url", lock_lines)] <- lock_lines[
    grepl("url", lock_lines)
  ] |>
    gsub(pattern = "tarball/.*", replacement = "tarball/xxx")
  lock_lines[grepl("checksum", lock_lines)] <- lock_lines[
    grepl("checksum", lock_lines)
  ] |>
    gsub(pattern = "git:.*", replacement = "git:xxx")

  lock_lines[-(1:11)] |>
    expect_identical(c(
      "[[package]]",
      "name = \"uvr\"",
      "version = \"x.x.x\"",
      "source = \"github\"",
      "url = \"https://api.github.com/repos/nbafrank/uvr-r/tarball/xxx\"",
      "checksum = \"git:xxx\""
    ))

  # TODO: test do_lock set to TRUE, do_install set to TRUE
})
