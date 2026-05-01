test_that("add works and errors on empty packages", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  expect_no_error(add("nbafrank/uvr-r", bin = path, dir = temp_dir))
  expect_error(add(character(0)), "length\\(packages\\) > 0L")

  # TODO: test that package added correctly
})
