test_that("install_uvr works", {
  # runs on CI too (#18): installs into a temp dir, nothing system-wide.
  # force = TRUE because .find_uvr_path always consults system locations
  # (/usr/local/bin, LOCALAPPDATA) where CI pre-installs uvr — without it
  # install_uvr early-returns "already installed" and nothing lands in
  # temp_dir.
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()

  expect_no_error(install_uvr(install_dir = temp_dir, force = TRUE))
  expect_true(file.exists(
    file.path(temp_dir, ".cargo", "bin", .get_bin_name())
  ))
})

test_that("install_uvr returns early when already installed", {
  with_mocked_bindings(
    expect_message(install_uvr(force = FALSE), "already installed"),
    .find_uvr_path = \(...) "path/to/uvr"
  )
})

test_that("install_uvr(method='binary') stops when no binary available", {
  # Mock .try_install_binary and .find_uvr_path to return NULL
  with_mocked_bindings(
    expect_error(
      install_uvr(method = "binary"),
      "No pre-built binary"
    ),
    .find_uvr_path = \(...) NULL,
    .try_install_binary = \(...) NULL
  )
})

test_that("install_uvr validates the timeout argument", {
  expect_error(install_uvr(timeout = "60"), "single positive number")
  expect_error(install_uvr(timeout = -5), "single positive number")
  expect_error(install_uvr(timeout = c(30, 60)), "single positive number")
})

test_that("download timeout gives a clear error and restores options(timeout)", {
  old_timeout <- getOption("timeout")
  with_mocked_bindings(
    expect_error(
      .get_and_extract_binary(
        "https://example.invalid/uvr.tar.gz",
        .make_temp_dir(),
        timeout = 1
      ),
      "timed out after 1 seconds"
    ),
    .download_file = function(url, destfile) {
      warning("Timeout of 1 seconds was reached")
      stop("download from 'https://example.invalid/uvr.tar.gz' failed")
    }
  )
  expect_identical(getOption("timeout"), old_timeout)
})

test_that("timeout error suggests retrying with a larger timeout", {
  with_mocked_bindings(
    expect_error(
      .get_and_extract_binary(
        "https://example.invalid/uvr.tar.gz",
        .make_temp_dir(),
        timeout = 2
      ),
      "install_uvr\\(timeout = 300"
    ),
    .download_file = function(url, destfile) {
      warning("Timeout of 2 seconds was reached")
      stop("download failed")
    }
  )
})

test_that("non-timeout download failure messages and returns NULL", {
  with_mocked_bindings(
    {
      expect_message(
        result <- .get_and_extract_binary(
          "https://example.invalid/uvr.tar.gz",
          .make_temp_dir()
        ),
        "Download failed"
      )
      expect_null(result)
    },
    .download_file = function(url, destfile) stop("404 Not Found")
  )
})

test_that(".get_release_details works for latest release", {
  skip_on_cran()
  skip_if_offline()
  latest_release <- .get_release_details() |>
    expect_silent() |>
    expect_no_error()

  expect_all_true(
    c("assets", "asset") %in% names(latest_release)
  )
  expect_true(
    nrow(latest_release$asset) > 0
  )
  expect_true(
    length(latest_release$asset$browser_download_url) == 1
  )
})

test_that(".get_release_details works for earlier release", {
  skip_on_cran()
  skip_if_offline()
  earlier_release <- .get_release_details(tag = "v0.3.2") |>
    expect_silent() |>
    expect_no_error()

  expect_all_true(
    c("assets", "asset") %in% names(earlier_release)
  )
  expect_true(
    nrow(earlier_release$asset) > 0
  )
  expect_true(
    length(earlier_release$asset$browser_download_url) == 1
  )
})

test_that("an earlier release can be installed from binary (#23)", {
  skip_on_cran()
  skip_if_offline()
  temp_dir <- .make_temp_dir()

  bin <- install_uvr(
    tag = "v0.4.1",
    method = "binary",
    install_dir = temp_dir,
    force = TRUE
  )
  expect_true(file.exists(bin))
  version_output <- system2(bin, "--version", stdout = TRUE)
  expect_match(version_output, "0\\.4\\.1")
})

test_that("cargo install builds the requested tag (#23)", {
  temp_dir <- .make_temp_dir()
  # Satisfy the cargo-locating fallback without a real toolchain
  fake_cargo_dir <- file.path(temp_dir, ".cargo", "bin")
  dir.create(fake_cargo_dir, recursive = TRUE)
  file.create(file.path(fake_cargo_dir, .get_bin_name("cargo")))

  captured_args <- NULL
  with_mocked_bindings(
    {
      bin <- .install_via_cargo(tag = "v0.4.1", install_dir = temp_dir)
      expect_true(file.exists(bin))
    },
    .run_cargo = function(command, args) {
      captured_args <<- args
      # simulate a successful build dropping the binary in place
      file.create(file.path(fake_cargo_dir, .get_bin_name()))
      0L
    }
  )
  expect_contains(captured_args, c("--tag", "v0.4.1"))
  expect_contains(captured_args, "https://github.com/nbafrank/uvr")
})
