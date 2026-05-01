test_that("init works", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  init(bin = path, dir = temp_dir)
  add("nbafrank/uvr-r", bin = path, dir = temp_dir)

  expect_no_error(sync(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(dir.exists(file.path(temp_dir, ".uvr/library/uvr")))

  # TODO: test frozen = TRUE
})
