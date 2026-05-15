test_that("update_pkgs works", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  expect_no_error(
    update_pkgs(do_sync = FALSE, bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_no_error(update_pkgs(bin = path, dir = temp_dir, quiet = TRUE))
})
