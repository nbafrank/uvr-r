test_that("find_uvr returns a path when uvr is installed", {
  path <- find_uvr()

  # Try installing if not found
  if (!file.exists(path)) {
    install_uvr()
  }
  path <- find_uvr()
  expect_true(file.exists(path))
})

test_that(".find_uvr_path can restrict the search to install_dir", {
  temp_dir <- .make_temp_dir()
  bin_dir <- file.path(temp_dir, ".cargo", "bin")
  dir.create(bin_dir, recursive = TRUE)
  file.create(file.path(bin_dir, .get_bin_name()))

  # A binary under install_dir is found either way
  expect_identical(
    .find_uvr_path(
      install_dir = temp_dir,
      check_path = FALSE,
      system_fallbacks = FALSE
    ),
    file.path(bin_dir, .get_bin_name())
  )

  # An empty install_dir with fallbacks off finds nothing — even on
  # machines (like CI) with a system-wide uvr in /usr/local/bin
  empty_dir <- file.path(temp_dir, "empty")
  dir.create(empty_dir)
  expect_null(
    .find_uvr_path(
      install_dir = empty_dir,
      check_path = FALSE,
      system_fallbacks = FALSE
    )
  )
})
