test_that("install_uvr returns early when already installed", {
  local_mocked_bindings(
    .find_uvr_path = \(...) "path/to/uvr",
    .env = asNamespace("uvr")
  )
  expect_message(install_uvr(force = FALSE), "already installed")
})

test_that("install_uvr(method='binary') stops when no binary available", {
  # Mock .try_install_binary and .find_uvr_path to return NULL
  local_mocked_bindings(
    .find_uvr_path = \(...) NULL,
    .try_install_binary = \(...) NULL,
    .env = asNamespace("uvr")
  )
  expect_error(
    install_uvr(method = "binary", force = TRUE),
    "No pre-built binary"
  )
})

test_that(".get_latest_release_details works", {
  latest_release <- .get_latest_release_details() |>
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
