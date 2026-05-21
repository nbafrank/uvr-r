test_that("install_uvr works", {
  skip_on_ci()
  temp_dir <- .make_temp_dir()

  expect_no_error(install_uvr(install_dir = temp_dir))
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
