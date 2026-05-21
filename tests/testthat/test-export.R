test_that("export works and can output to any file name", {
  temp_dir <- .make_temp_dir()
  path <- setup_uvr_test(temp_dir = temp_dir, init = TRUE, add = TRUE) # installs uvr if needed

  # cli output, no file created
  x <- expect_no_error(export(bin = path, dir = temp_dir, quiet = TRUE))
  expect_true(length(x) > 0L)
  expect_true(any(grepl("\"jsonlite\"", x)))
  expect_true(!file.exists(file.path(temp_dir, "renv.lock")))

  # files created
  expect_no_error(
    export(out_file = "renv.lock", bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_true(file.exists(file.path(temp_dir, "renv.lock")))
  expect_no_error(
    export(out_file = "renv.test", bin = path, dir = temp_dir, quiet = TRUE)
  )
  expect_true(file.exists(file.path(temp_dir, "renv.test")))
})
