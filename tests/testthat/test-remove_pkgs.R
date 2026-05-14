test_that("remove_pkgs works and errors on empty packages", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  expect_no_error(
    remove_pkgs("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_error(
    remove_pkgs(character(0), quiet = TRUE),
    "length\\(packages\\) > 0L"
  )
})
