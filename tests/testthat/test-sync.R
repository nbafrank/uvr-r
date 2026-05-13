test_that("sync works", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  init(bin = path, dir = temp_dir, quiet = TRUE)
  add("jsonlite", bin = path, dir = temp_dir, quiet = TRUE)

  expect_no_error(sync(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/jsonlite")))

  # TODO: test frozen = TRUE
  # TODO: test cache files are created
})
