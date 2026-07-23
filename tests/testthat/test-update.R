test_that("update_uvr works", {
  # runs on CI too (#18): installs the R package + binary into temp dirs
  skip_on_cran()
  skip_if_offline()
  skip_if_not_installed("pak")
  temp_dir <- .make_temp_dir()
  # pak refuses to run under R CMD check unless R_USER_CACHE_DIR is set
  # (see r-lib/pkgcache README)
  withr::local_envvar(R_USER_CACHE_DIR = file.path(temp_dir, ".r-cache"))
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
