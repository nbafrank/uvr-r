test_that("update_uvr works", {
  skip_on_ci()
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(
    temp_dir = temp_dir,
    check_existing = FALSE
  ) # installs uvr in temp_dir
  package_dir <- file.path(temp_dir, ".uvr/library")
  dir.create(package_dir, showWarnings = FALSE, recursive = TRUE)

  expect_no_error(
    update_uvr(install_dir = temp_dir, package_dir = package_dir, quiet = TRUE)
  )

  expect_contains(list.files(package_dir), "uvr")
})
