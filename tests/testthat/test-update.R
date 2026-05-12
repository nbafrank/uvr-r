test_that("update_uvr works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(
    temp_dir = temp_dir,
    check_existing = FALSE
  ) # installs uvr in temp_dir
  package_dir <- file.path(temp_dir, ".uvr/library")
  dir.create(package_dir, showWarnings = FALSE, recursive = TRUE)

  expect_no_error(update_uvr(
    install_dir = temp_dir,
    package_dir = package_dir
  ))

  expect_contains(list.files(package_dir), "uvr")

  # TODO: test other `ref` and `method` values
})
