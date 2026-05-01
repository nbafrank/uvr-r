test_that("init works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)

  expect_no_error(init(bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "uvr.toml")))
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library")))
})

# TODO: add tests for when DESCRIPTION exists
