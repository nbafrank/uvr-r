test_that("run works and requires script argument", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  file.copy(system.file("extdata/test.R", package = "uvr"), temp_dir)
  expect_no_error(run(script = "test.R", bin = path, dir = temp_dir))

  expect_error(run(), "missing")

  # TODO: test output?
})
