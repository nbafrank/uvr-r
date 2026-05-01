test_that("install_uvr returns early when already installed", {
  skip_if_no_uvr()
  expect_message(install_uvr(force = FALSE), "already installed")
})

test_that("install_uvr(method='binary') stops when no binary available", {
  skip_if_no_uvr()
  # Mock .try_install_binary to return NULL
  mockenv <- new.env(parent = asNamespace("uvr"))
  local({
    # Force .find_uvr_path to return NULL so it doesn't short-circuit
    assign(".find_uvr_path", function() NULL, envir = parent.env(environment()))
    assign(
      ".try_install_binary",
      function() NULL,
      envir = parent.env(environment())
    )
  })
  expect_error(
    withr::with_environment(
      mockenv,
      install_uvr(method = "binary", force = TRUE)
    ),
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
