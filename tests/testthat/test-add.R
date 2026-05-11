test_that("add works and errors on empty packages", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir) # installs uvr if needed

  init(bin = path, dir = temp_dir)
  expect_no_error(add("jsonlite", bin = path, dir = temp_dir))
  expect_error(add(character(0)), "length\\(packages\\) > 0L")

  # TODO: test that package added correctly
})
