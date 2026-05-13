test_that("add works and errors on empty packages", {
  temp_dir <- .make_temp_dir()
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE) # installs uvr if needed

  expect_no_error(add("jsonlite", bin = path, dir = temp_dir, quiet = TRUE))
  expect_error(add(character(0), quiet = TRUE), "length\\(packages\\) > 0L")

  # Case: add github repo with mismatch pkgname/repo name (i.e nbafrank/uvr-r -> uvr)
  skip("waiting on 0.3.5 release of uvr with relevant fix")
  expect_no_error(
    add("nbafrank/uvr-r", bin = path, dir = temp_dir, quiet = TRUE)
  )

  # TODO: test that package added correctly
})
