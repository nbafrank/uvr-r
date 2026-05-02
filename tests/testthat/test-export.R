test_that("export works and can output to any file name", {
  path <- setup_uvr_test() # installs uvr if needed
  temp_dir <- tempfile("uvr-test-")
  dir.create(temp_dir, recursive = TRUE)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  init(bin = path, dir = temp_dir)
  add("nbafrank/uvr-r", bin = path, dir = temp_dir)

  expect_no_error(export(out_file = "renv.lock", bin = path, dir = temp_dir))
  expect_true(file.exists(file.path(temp_dir, "renv.lock")))

  expect_no_error(export(
    out_file = "renv-test.locktest",
    bin = path,
    dir = temp_dir
  ))
  expect_true(file.exists(file.path(temp_dir, "renv-test.locktest")))
})
