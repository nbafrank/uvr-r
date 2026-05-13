test_that("update_pkgs works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  init(bin = path, dir = temp_dir, quiet = TRUE)
  add("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)

  expect_no_error(
    update_pkgs(do_sync = FALSE, bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_no_error(update_pkgs(bin = path, dir = temp_dir, quiet = TRUE))
  # TODO: inspect files
})
