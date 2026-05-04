test_that("update_pkgs works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  init(bin = path, dir = temp_dir)
  add("jsonlite", bin = path, dir = temp_dir)

  expect_no_error(update_pkgs(sync = FALSE, bin = path, dir = temp_dir))
  expect_no_error(update_pkgs(bin = path, dir = temp_dir))
  # TODO: inspect files
})
